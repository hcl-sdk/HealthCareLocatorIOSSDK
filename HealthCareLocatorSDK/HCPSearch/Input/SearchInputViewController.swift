//
//  SearchInputViewController.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import MapKit

class SearchInputViewController: UIViewController, ViewDesign {
    private let disposeBag = DisposeBag()
    
    private var webService: SearchAPIsProtocol = HCLHCPSearchWebServices(manager: HCLServiceManager.shared)
    private let viewModel = SearchInputViewModel()
    private var resultDataSource: SearchInputDataSource!
    private var searchInput: String = ""
    
    // Individual
    private var searchInputAutocompleteModelView: SearchInputAutocompleteViewModel!
    
    // Address
    var data: SearchData?
    private let searchCompleter = MKLocalSearchCompleter()
    private var searchResult = [SearchAutoComplete]() {
        didSet {
            if isViewLoaded {
                resultDataSource.reloadWith(result: searchResult, input: searchInput)
            }
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var categorySearchTextField: UITextField!
    @IBOutlet weak var locationSearchTextField: UITextField!
    @IBOutlet weak var searchBtn: BaseButton!
    @IBOutlet weak var separatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultDataSource = SearchInputDataSource(tableView: searchResultTableView,
                                                 theme: theme,
                                                 icons: icons)
        resultDataSource.delegate = self
        searchCompleter.delegate = self
        categorySearchTextField.delegate = self
        categorySearchTextField.rightViewMode = .always
        locationSearchTextField.delegate = self
        locationSearchTextField.rightViewMode = .always

        searchInputAutocompleteModelView = SearchInputAutocompleteViewModel(webServices: webService as! HCLHCPSearchWebServices)
        
        layoutWith(theme: theme, icons: icons)
        
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
    
    func initializeWith(data: SearchData) {
        switch data.mode {
        case .addressSearch(let address):
            locationSearchTextField.text = address
        default:
            locationSearchTextField.text = kNearMeTitle
        }
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
            strongSelf.viewModel.showLoading(isLoading: isLoading, for: strongSelf.categorySearchTextField)
        }).disposed(by: disposeBag)
        
        let firstFieldCriteria = categorySearchTextField.rx.controlEvent([.editingChanged])
            .map { [weak self] in self?.categorySearchTextField.text ?? ""}
            .distinctUntilChanged()
        
        let searchCriteria = firstFieldCriteria.debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        
        searchCriteria.bind(to: searchInputAutocompleteModelView.autocompleteCreteriaSubject).disposed(by: disposeBag)
                
        Observable.zip(searchInputAutocompleteModelView.codesObservable(config: HCLManager.shared),
                       searchInputAutocompleteModelView.individualsObservable(config: HCLManager.shared))
            .subscribe(onNext: {[weak self] (codes, individuals) in
                guard let strongSelf = self else {return}
                var result = [SearchAutoComplete]()
                result.append(contentsOf: codes.map {SearchAutoComplete.Code(code: $0)})
                result.append(contentsOf: individuals.map {SearchAutoComplete.Individual(individual: $0)})
                strongSelf.searchResult = result.count > 0 ? result : [.NearMe]
            }).disposed(by: disposeBag)
    }
    
    func layoutWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        viewModel.layout(view: self, with: theme, icons: icons)
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        let validator = SearchInputValidator()
        // Search near me criteria is not mandatory
        let isCriteriaValid = validator.isCriteriaValid(criteriaText: categorySearchTextField.text) || searchInputAutocompleteModelView.isNearMeSearch
        
        if !isCriteriaValid {
            categorySearchTextField.setBorderWith(width: 2, cornerRadius: 8, borderColor: UIColor.red)
        } else {
            categorySearchTextField.setBorderWith(width: 0, cornerRadius: 8, borderColor: UIColor.clear)
        }
        
        if isCriteriaValid {
            if searchInputAutocompleteModelView.isNearMeSearch {
                LocationManager.shared.requestAuthorization {[weak self] (status) in
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
    
    private func performSearchingWith(criteria: String? = nil,
                                      code: Code? = nil,
                                      address: String? = nil,
                                      isNearMeSearch: Bool? = false) {
        var searchData: SearchData!
        if isNearMeSearch == true {
            let mode: SearchData.Mode = (criteria == nil && code == nil) ? .quickNearMeSearch : .nearMeSearch
            searchData = SearchData(criteria: criteria,
                                    codes: code != nil ? [code!] : nil,
                                    mode: mode)
        } else if let unwrapAddress = address, !unwrapAddress.isEmpty {
            searchData = SearchData(criteria: criteria,
                                    codes: code != nil ? [code!] : nil,
                                    mode: .addressSearch(address: unwrapAddress))
        } else {
            searchData = SearchData(criteria: criteria,
                                    codes: code != nil ? [code!] : nil,
                                    mode: .baseSearch(country: HCLManager.shared.searchConfigure?.country))
        }
        
        // Save last search
        AppConfigure.save(search: searchData)
        // Go search
        performSegue(withIdentifier: "showResultVC", sender: searchData)
    }
    
    // MARK: - Navigation

    @IBAction func unwindToSearchInputViewController(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showResultVC":
                if let desVC = segue.destination as? SearchResultViewController,
                   let data = sender as? SearchData {
                    desVC.data = data
                }
            case "showFullCardVC":
                if let desVC = segue.destination as? HCPFullCardViewController {
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

// MARK: Textfield delegate
extension SearchInputViewController: UITextFieldDelegate {
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
        // NOTE: wont allow to edit the selected code after select, the user MUST clear the code instead
        if textField == categorySearchTextField && searchInputAutocompleteModelView.isSelectedCode() {
            return false
        } else {
            textField.setBorderWith(width: 0, cornerRadius: 8, borderColor: .clear)
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let searchText = text.replacingCharacters(in: textRange, with: string)
                if textField == locationSearchTextField {
                    searchInputAutocompleteModelView.set(address: searchText)
                    searchCompleter.queryFragment = searchText
                } else {
                    searchInputAutocompleteModelView.set(criteria: searchText)
                    searchInput = searchText
                }
            }
            
            return true
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == categorySearchTextField {
            searchInputAutocompleteModelView.set(criteria: nil)
        }
        
        return true
    }
}

// MARK: Place autocomplete delegate
extension SearchInputViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        var newList: [SearchAutoComplete] = [.NearMe]
        newList.append(contentsOf: completer.results.map {SearchAutoComplete.Address(address: $0)})
        searchResult = newList
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension SearchInputViewController: SearchInputDataSourceDelegate {
    func didSelect(result: SearchAutoComplete) {
        switch result {
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
