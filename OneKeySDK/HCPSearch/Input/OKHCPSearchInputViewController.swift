//
//  OKHCPSearchInputViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import MapKit

class OKHCPSearchInputViewController: UIViewController, OKViewDesign {
    private let disposeBag = DisposeBag()
    
    var theme: OKThemeConfigure?

    private var webService: OKHCPSearchWebServicesProtocol = OKHCPSearchWebServices(apiKey: OKManager.shared.apiKey.orEmpty,
                                                                                    manager: OKServiceManager.shared)
        
    // Individual
    private var searchInputAutocompleteModelView: SearchInputAutocompleteViewModel!
    
    // Address
    var data: OKHCPSearchData?
    private let searchCompleter = MKLocalSearchCompleter()
    private var searchResult = [SearchAutoComplete]() {
        didSet {
            if isViewLoaded {
                searchResultTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var categorySearchTextField: UITextField!
    @IBOutlet weak var locationSearchTextField: UITextField!
    @IBOutlet weak var searchBtn: OKBaseButton!
    @IBOutlet weak var separatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self
        searchResultTableView.register(UINib(nibName: "SearchResultTableViewCell",
                                             bundle: Bundle.internalBundle()),
                                       forCellReuseIdentifier: "SearchResultTableViewCell")
        
        searchResultTableView.register(UINib(nibName: "CodeAutoCompleteTableViewCell",
                                             bundle: Bundle.internalBundle()),
                                       forCellReuseIdentifier: "CodeAutoCompleteTableViewCell")
        
        searchResultTableView.register(UINib(nibName: "IndividualAutoCompleteTableViewCell",
                                             bundle: Bundle.internalBundle()),
                                       forCellReuseIdentifier: "IndividualAutoCompleteTableViewCell")
        
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        searchResultTableView.tableFooterView = UIView()
        categorySearchTextField.delegate = self
        categorySearchTextField.rightViewMode = .always
        locationSearchTextField.delegate = self
        locationSearchTextField.rightViewMode = .always

        searchInputAutocompleteModelView = SearchInputAutocompleteViewModel(webServices: webService as! OKHCPSearchWebServices)
        
        if let theme = theme {
            layoutWith(theme: theme)
        }
        
        if let data = data {
            initializeWith(data: data)
        }
        
        setupDataBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categorySearchTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(false)
    }
    
    func initializeWith(data: OKHCPSearchData) {
        locationSearchTextField.text = (data.isNearMeSearch == true || data.isQuickNearMeSearch == true) ? kNearMeTitle : data.address
        searchInputAutocompleteModelView.set(data: data)
    }
    
    func setupDataBinding() {
        categorySearchTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe(onNext: {[weak self] in
            self?.searchResultTableView.reloadData()
        })
        .disposed(by: disposeBag)
        /*
         Fetch autocomplete data by creteria with debounce 300 milisecond
         */
        searchInputAutocompleteModelView.isFirstFieldLoading().subscribe(onNext: {[weak self] isLoading in
            guard let strongSelf = self else {return}
            strongSelf.showLoading(isLoading: isLoading, for: strongSelf.categorySearchTextField)
        }).disposed(by: disposeBag)
        
        let firstFieldCriteria = categorySearchTextField.rx.controlEvent([.editingChanged])
            .map { [weak self] in self?.categorySearchTextField.text ?? ""}
            .distinctUntilChanged()
        
        let searchCriteria = firstFieldCriteria.debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        
        searchCriteria.bind(to: searchInputAutocompleteModelView.autocompleteCreteriaSubject).disposed(by: disposeBag)
                
        Observable.zip(searchInputAutocompleteModelView.codesObservable(),
                       searchInputAutocompleteModelView.individualsObservable())
            .subscribe(onNext: {[weak self] (codes, individuals) in
                guard let strongSelf = self else {return}
                var result = [SearchAutoComplete]()
                result.append(contentsOf: codes.map {SearchAutoComplete.Code(code: $0)})
                result.append(contentsOf: individuals.map {SearchAutoComplete.Individual(individual: $0)})
                strongSelf.searchResult = result.count > 0 ? result : [.NearMe]
            }).disposed(by: disposeBag)
    }
    
    func layoutWith(theme: OKThemeConfigure) {
        // Colors
        backButton.tintColor = theme.darkColor
        separatorView.backgroundColor = theme.greyLighterColor
        searchResultTableView.separatorColor = theme.greyLighterColor
        
        categorySearchTextField.attributedPlaceholder = NSAttributedString(string: "Name, specialty ?",
                                                                   attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        locationSearchTextField.attributedPlaceholder = NSAttributedString(string: "Where? (address, city...)",
                                                                   attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        categorySearchTextField.textColor = theme.darkColor
        locationSearchTextField.textColor = theme.darkColor
        
        searchBtn.backgroundColor = theme.primaryColor
        
        // Fonts
        categorySearchTextField.font = theme.searchInputFont
        locationSearchTextField.font = theme.searchInputFont
    }
    
    private func showLoading(isLoading: Bool, for field: UITextField) {
        if isLoading {
            let indicator = UIActivityIndicatorView(style: .gray)
            field.rightView = indicator
            indicator.startAnimating()
        } else {
            field.rightView = nil
        }
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        let validator = SearchInputValidator()
        // Search near me criteria is not mandatory
        let isCriteriaValid = validator.isCriteriaValid(criteriaText: categorySearchTextField.text)
        
        if !isCriteriaValid {
            categorySearchTextField.setBorderWith(width: 2, cornerRadius: 8, borderColor: UIColor.red)
        }
        
        if isCriteriaValid {
            if searchInputAutocompleteModelView.isNearMeSearch {
                OKLocationManager.shared.requestAuthorization {[weak self] (status) in
                    guard let strongSelf = self else {return}
                    switch status {
                    case .authorizedAlways, .authorizedWhenInUse:
                        strongSelf.performSearchingWith(criteria: strongSelf.searchInputAutocompleteModelView.creteria,
                                                        code: strongSelf.searchInputAutocompleteModelView.selectedCode,
                                                        address: strongSelf.searchInputAutocompleteModelView.address,
                                                        isNearMeSearch: strongSelf.searchInputAutocompleteModelView.isNearMeSearch)
                    default:
                        // TODO: Handle error
                        break
                    }
                }
            } else {
                performSearchingWith(criteria: searchInputAutocompleteModelView.creteria,
                                     code: searchInputAutocompleteModelView.selectedCode,
                                     address: searchInputAutocompleteModelView.address,
                                     isNearMeSearch: searchInputAutocompleteModelView.isNearMeSearch)
            }
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func performSearchingWith(criteria: String? = nil, code: Code? = nil, address: String? = nil, isNearMeSearch: Bool? = false) {
        let searchData = OKHCPSearchData(criteria: criteria,
                                         codes: code != nil ? [code!] : nil,
                                         address: address,
                                         isNearMeSearch: isNearMeSearch,
                                         isQuickNearMeSearch: false,
                                         result: [])
        // Save last search
        OKDatabase.save(search: searchData)
        // Go search
        performSegue(withIdentifier: "showResultVC", sender: searchData)
    }
    
    // MARK: - Navigation

    @IBAction func unwindToOKHCPSearchInputViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showResultVC":
                if let desVC = segue.destination as? OKHCPSearchResultViewController,
                   let data = sender as? OKHCPSearchData {
                    desVC.data = data
                    desVC.theme = theme
                }
            case "showFullCardVC":
                if let desVC = segue.destination as? OKHCPFullCardViewController {
                    desVC.theme = theme
                    if let individual = sender as? IndividualWorkPlaceDetails {
                        desVC.activityID = individual.mainActivity.id
                    }
                }
            default:
                return
            }
        }
    }
}

// MARK: TableView datasource
extension OKHCPSearchInputViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let theme = theme {
            switch searchResult[indexPath.row] {
            case .Code(let code):
                let cell = tableView.dequeueReusableCell(withIdentifier: "CodeAutoCompleteTableViewCell") as! CodeAutoCompleteTableViewCell
                cell.configWith(theme: theme,
                                code: code,
                                highlight: categorySearchTextField.text)
                return cell
            case .Individual(let individual):
                let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualAutoCompleteTableViewCell") as! IndividualAutoCompleteTableViewCell
                cell.configWith(theme: theme,
                                individual: individual,
                                highlight: categorySearchTextField.text)
                return cell
            case .NearMe:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
                cell.configWith(theme: theme,
                                iconImage: UIImage.OKImageWith(name: "geoloc")!,
                                title: kNearMeTitle)
                return cell
            case .Address(let address):
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
                cell.configWith(theme: theme,
                                iconImage: UIImage.OKImageWith(name: "marker")!,
                                title: "\(address.title), \(address.subtitle)")
                return cell
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchResult[indexPath.row] {
        case .NearMe:
            locationSearchTextField.text = kNearMeTitle
            searchInputAutocompleteModelView.set(isNearMeSearch: true)
            searchResult = []
        case .Address(let address):
            let composedAdd = "\(address.title), \(address.subtitle)"
            locationSearchTextField.text = composedAdd
            searchInputAutocompleteModelView.set(address: composedAdd)
            searchResult = []
        case .Code(let code):
            categorySearchTextField.text = code.longLbl
            searchInputAutocompleteModelView.set(code: code)
            locationSearchTextField.becomeFirstResponder()
        case .Individual(let individual):
            performSegue(withIdentifier: "showFullCardVC", sender: individual)
        }
    }
}

// MARK: Textfield delegate
extension OKHCPSearchInputViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let searchText = textField.text.orEmpty
        if textField == categorySearchTextField {
            if searchText.isEmpty {
                searchResult = [.NearMe]
            } else {
                searchResult = []
            }
            searchInputAutocompleteModelView.autocompleteCreteriaSubject.onNext(searchText)
        } else {
            searchResult = [.NearMe]
            searchCompleter.queryFragment = searchText
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.setBorderWith(width: 0, cornerRadius: 8, borderColor: .clear)
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let searchText = text.replacingCharacters(in: textRange, with: string)
            if textField == locationSearchTextField {
                searchInputAutocompleteModelView.set(address: searchText)
                searchCompleter.queryFragment = searchText
            } else {
                searchInputAutocompleteModelView.set(criteria: searchText)
            }
        }
        
        return true
    }
}

// MARK: Place autocomplete delegate
extension OKHCPSearchInputViewController: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        var newList: [SearchAutoComplete] = [.NearMe]
        newList.append(contentsOf: completer.results.map {SearchAutoComplete.Address(address: $0)})
        searchResult = newList
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
