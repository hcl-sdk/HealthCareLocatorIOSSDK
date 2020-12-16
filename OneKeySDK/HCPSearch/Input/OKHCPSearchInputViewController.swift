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

    private var webService: OKHCPSearchWebServicesProtocol = OKHCPSearchWebServices()//MockOKHCPSearchWebServices()
        
    // Individual
    private var searchInputAutocompleteModelView: SearchInputAutocompleteViewModel!
    
    // Address
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
    
    func setupDataBinding() {
        categorySearchTextField.rx.controlEvent([.editingChanged]).asObservable().subscribe(onNext: {[weak self] in
            self?.searchResultTableView.reloadData()
        })
        .disposed(by: disposeBag)
        /*
         Fetch autocomplete data by creteria with debounce 300 milisecond
         */
        let firstFieldCriteria = categorySearchTextField.rx.controlEvent([.editingChanged])
            .map { [weak self] in self?.categorySearchTextField.text ?? ""}
            .distinctUntilChanged().filter {$0.count >= 3}
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        
        firstFieldCriteria.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            let indicator = UIActivityIndicatorView(style: .gray)
            self?.categorySearchTextField.rightView = indicator
            indicator.startAnimating()
        }).disposed(by: disposeBag)
        
        firstFieldCriteria.bind(to: searchInputAutocompleteModelView.autocompleteCreteriaSubject).disposed(by: disposeBag)
        
        Observable.zip(searchInputAutocompleteModelView.codesObservable(),
                       searchInputAutocompleteModelView.individualsObservable())
        .subscribe(onNext: {[weak self] (codes, individuals) in
                guard let strongSelf = self else {return}
                var result = [SearchAutoComplete]()
                result.append(contentsOf: codes.map {SearchAutoComplete.Code(code: $0)})
                result.append(contentsOf: individuals.map {SearchAutoComplete.Individual(individual: $0)})
                strongSelf.searchResult = result
                strongSelf.categorySearchTextField.rightView = nil
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
    
    @IBAction func onSearchAction(_ sender: Any) {
        let validator = SearchInputValidator()
        let isCriteriaValid = validator.isCriteriaValid(criteriaText: categorySearchTextField.text)
        
        if !isCriteriaValid {
            categorySearchTextField.setBorderWith(width: 2, cornerRadius: 8, borderColor: UIColor.red)
        }
        
        if isCriteriaValid {
            performSearchingWith(criteria: searchInputAutocompleteModelView.creteria,
                                 code: searchInputAutocompleteModelView.selectedCode,
                                 address: searchInputAutocompleteModelView.address,
                                 isNearMeSearch: searchInputAutocompleteModelView.isNearMeSearch)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func performSearchingWith(criteria: String? = nil, code: Code? = nil, address: String? = nil, isNearMeSearch: Bool? = false) {
        let searchData = OKHCPSearchData(criteria: criteria,
                                         code: code,
                                         address: address,
                                         isNearMeSearch: isNearMeSearch,
                                         result: [])
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
        default:
            break
        }
    }
}

// MARK: Textfield delegate
extension OKHCPSearchInputViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == categorySearchTextField {
            searchResult = []
        } else {
            searchResult = [.NearMe]
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
