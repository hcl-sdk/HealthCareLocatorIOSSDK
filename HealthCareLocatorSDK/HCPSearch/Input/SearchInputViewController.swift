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
import Contacts

class SearchInputViewController: UIViewController, ViewDesign {
    
    private let disposeBag = DisposeBag()
    private var webService = HCLHCPSearchWebServices(manager: HCLServiceManager.shared)
    private let viewModel = SearchInputViewModel()
    private var resultDataSource: SearchInputDataSource!
    private var searchInput = ""
    private var isSelectedAddress = false
    private var selectedAddress = ""
    private var currentCountry = ""
    
    // Individual
    private var searchInputAutocompleteModelView: SearchInputAutocompleteViewModel!
    
    // Address
    var data: SearchData?
    private let searchCompleter = MKLocalSearchCompleter()
    private var searchAddressResult: [String] = []
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
    @IBOutlet weak var specialtySearchTextField: UITextField!
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
        specialtySearchTextField.delegate = self
        specialtySearchTextField.rightViewMode = .always
        locationSearchTextField.delegate = self
        locationSearchTextField.rightViewMode = .always
        searchInputAutocompleteModelView = SearchInputAutocompleteViewModel(webServices: webService)
        
        layoutWith(theme: theme, icons: icons)
        getCountryByLocation()
        
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
            if !selectedAddress.isEmpty {
                locationSearchTextField.text = selectedAddress
            } else {
                locationSearchTextField.text = address
            }
        default:
            locationSearchTextField.text = kNearMeTitle
        }
        searchInputAutocompleteModelView.set(data: data)
    }
    
    func setupDataBinding() {
        // categorySearchTextField
        searchInputAutocompleteModelView.isLoadingIndividuals.subscribe(onNext: {[weak self] isLoading in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.showLoading(isLoading: isLoading, for: strongSelf.categorySearchTextField)
        }).disposed(by: disposeBag)
        
        let categoryField = categorySearchTextField.rx.controlEvent([.editingChanged])
            .map { [weak self] in self?.categorySearchTextField.text ?? ""}
            .distinctUntilChanged()
        
        let categorySearch = categoryField.debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        
        categorySearch.bind(to: searchInputAutocompleteModelView.individualsCreteriaSubject).disposed(by: disposeBag)
        
        searchInputAutocompleteModelView.individualsObservable(config: HCLManager.shared)
            .subscribe(onNext: {[weak self] (individuals) in
                guard let strongSelf = self else {return}
                var result = [SearchAutoComplete]()
                result.append(contentsOf: individuals.map {SearchAutoComplete.Individual(individual: $0)})
                strongSelf.searchResult = result.count > 0 ? result : [.NearMe]
                // Auto complete for categorySearchTextField when data was updated
                strongSelf.handleDataForAutoComplete(strongSelf.categorySearchTextField, searchResult: strongSelf.searchResult)
            }).disposed(by: disposeBag)
        
        // specialtySearchTextField
        searchInputAutocompleteModelView.isLoadingCodes.subscribe(onNext: {[weak self] isLoading in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.showLoading(isLoading: isLoading, for: strongSelf.specialtySearchTextField)
        }).disposed(by: disposeBag)
        
        let specialtyField = specialtySearchTextField.rx.controlEvent([.editingChanged])
            .map { [weak self] in self?.specialtySearchTextField.text ?? ""}
            .distinctUntilChanged()
        
        let specialtySearch = specialtyField.debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        
        specialtySearch.bind(to: searchInputAutocompleteModelView.codesCreteriaSubject).disposed(by: disposeBag)
        
        searchInputAutocompleteModelView.codesObservable(config: HCLManager.shared)
            .subscribe(onNext: {[weak self] (codes) in
                guard let strongSelf = self else {return}
                var result = [SearchAutoComplete]()
                result.append(contentsOf: codes.map {SearchAutoComplete.Code(code: $0)})
                strongSelf.searchResult = result.count > 0 ? result : [.NearMe]
                // Auto complete for specialtySearchTextField when data was updated
                strongSelf.handleDataForAutoComplete(strongSelf.specialtySearchTextField, searchResult: strongSelf.searchResult)
            }).disposed(by: disposeBag)
    }
    
    func handleDataForAutoComplete(_ textField: UITextField, searchResult: [SearchAutoComplete]) {
        guard let string = textField.text, textField.isEditing else { return }
        var searchResultList = [String]()
        searchResult.forEach({ searchResultList.append($0.value) })
        self.autoCompleteText(in: textField, searchResult: searchResultList, using: string.capitalized)
    }
    
    func layoutWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        viewModel.layout(view: self, with: theme, icons: icons)
    }
    
    private func getCountryByLocation() {
        if let currentLocation = LocationManager.shared.currentLocation {
            currentLocation.placemark { placemark, error in
                guard let placemark = placemark else {
                    print("Error:", error ?? "nil")
                    return
                }
                self.currentCountry = placemark.postalCountryFormatted?.lowercased() ?? ""
            }
        }
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        // Auto complete
        if let text = categorySearchTextField.text, !text.isEmpty {
            categorySearchTextField.text = searchInputAutocompleteModelView.creteria ?? text
        }
        if let text = specialtySearchTextField.text, !text.isEmpty {
            specialtySearchTextField.text = searchInputAutocompleteModelView.selectedCode?.longLbl ?? text
        }
        if let text = locationSearchTextField.text, !text.isEmpty, locationSearchTextField.isEditing {
            locationSearchTextField.text = searchInputAutocompleteModelView.address ?? text
        }
        
        // Search near me criteria is not mandatory
        let validator = SearchInputValidator()
        let isCriteriaValid = validator.isCriteriaValid(criteriaText: categorySearchTextField.text)
            || validator.isCriteriaValid(criteriaText: specialtySearchTextField.text)
            || searchInputAutocompleteModelView.isNearMeSearch
        
        if !isCriteriaValid {
            categorySearchTextField.setBorderWith(width: 2, cornerRadius: 8, borderColor: .red)
            specialtySearchTextField.setBorderWith(width: 2, cornerRadius: 8, borderColor: .red)
        } else {
            categorySearchTextField.setBorderWith(width: 0, cornerRadius: 8, borderColor: .clear)
            specialtySearchTextField.setBorderWith(width: 0, cornerRadius: 8, borderColor: .clear)
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
                if !isSelectedAddress,
                   let location = locationSearchTextField.text, !location.isEmpty {
                    locationSearchTextField.setBorderWith(width: 2, cornerRadius: 8, borderColor: .red)
                } else {
                    locationSearchTextField.setBorderWith(width: 0, cornerRadius: 8, borderColor: .clear)
                    performSearchingWith(criteria: searchInputAutocompleteModelView.creteria,
                                         code: searchInputAutocompleteModelView.selectedCode,
                                         address: selectedAddress,
                                         isNearMeSearch: searchInputAutocompleteModelView.isNearMeSearch)
                }
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
        // Use data from the view controller which initiated the unwind segue
        // let sourceViewController = unwindSegue.source
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
        if textField == categorySearchTextField || textField == specialtySearchTextField {
            if searchText.isEmpty {
                searchResult = [.NearMe]
            } else {
                searchResult = []
            }
            textField == categorySearchTextField ? searchInputAutocompleteModelView.individualsCreteriaSubject.onNext(searchText) : searchInputAutocompleteModelView.codesCreteriaSubject.onNext(searchText)
        } else {
            searchResult = [.NearMe]
            searchCompleter.queryFragment = searchText
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == categorySearchTextField {
            if let text = categorySearchTextField.text, !text.isEmpty {
                categorySearchTextField.text = searchInputAutocompleteModelView.creteria ?? text
            }
        } else if textField == specialtySearchTextField {
            if let text = specialtySearchTextField.text, !text.isEmpty {
                specialtySearchTextField.text = searchInputAutocompleteModelView.selectedCode?.longLbl ?? text
            }
        } else {
            if let text = locationSearchTextField.text, !text.isEmpty {
                locationSearchTextField.text = searchInputAutocompleteModelView.address ?? text
            }
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // NOTE: wont allow to edit the selected code after select, the user MUST clear the code instead
        if textField == specialtySearchTextField && searchInputAutocompleteModelView.isSelectedCode() {
            return false
        } else {
            textField.setBorderWith(width: 0, cornerRadius: 8, borderColor: .clear)
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let searchText = text.replacingCharacters(in: textRange, with: string)
                if textField == locationSearchTextField {
                    searchInputAutocompleteModelView.set(address: searchText)
                    searchCompleter.queryFragment = searchText
                } else if textField == categorySearchTextField {
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
        } else if textField == specialtySearchTextField {
            searchInputAutocompleteModelView.set(code: nil)
        } else {
            selectedAddress = ""
            isSelectedAddress = false
            searchInputAutocompleteModelView.clearLocationField()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == categorySearchTextField {
            specialtySearchTextField.becomeFirstResponder()
            if let text = categorySearchTextField.text, !text.isEmpty {
                categorySearchTextField.text = searchInputAutocompleteModelView.creteria ?? text
            }
        } else if textField == specialtySearchTextField {
            locationSearchTextField.becomeFirstResponder()
            if let text = specialtySearchTextField.text, !text.isEmpty {
                specialtySearchTextField.text = searchInputAutocompleteModelView.selectedCode?.longLbl ?? text
            }
        } else {
            if let text = locationSearchTextField.text, !text.isEmpty {
                locationSearchTextField.text = searchInputAutocompleteModelView.address ?? text
            }
            onSearchAction(textField)
        }
        return true
    }
    
    private func autoCompleteText(in textField: UITextField, searchResult arrayString: [String], using string: String) {
        if !string.isEmpty {
            let matches = Array(arrayString.filter({$0.lowercased().contains(string.lowercased())}))
            if matches.count > 0 {
                guard let text = matches.first else { return }
                if textField == categorySearchTextField {
                    searchInputAutocompleteModelView.set(criteria: text)
                } else if textField == specialtySearchTextField {
                    let itemsFiltered = searchResult.filter({$0.type == "code" && $0.value == text})
                    guard let item = itemsFiltered.first, let code = item.getCodeType() else { return }
                    searchInputAutocompleteModelView.set(code: code)
                } else {
                    isSelectedAddress = true
                    selectedAddress = text
                    searchInputAutocompleteModelView.set(address: text)
                }
            } else {
                if textField == locationSearchTextField {
                    isSelectedAddress = false
                } else if textField == specialtySearchTextField {
                    searchInputAutocompleteModelView.set(code: nil)
                }
            }
        }
    }
}

// MARK: Place autocomplete delegate
extension SearchInputViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        var newList: [SearchAutoComplete] = [.NearMe]
        if !currentCountry.isEmpty {
            newList.append(contentsOf: completer.results.map {
                if $0.subtitle.lowercased().contains(currentCountry) {
                    return SearchAutoComplete.Address(address: $0)
                } else {
                    return .none
                }
            })
        } else if let country = HCLManager.shared.searchConfigure?.country {
            // handle countries in a string
            var countriesString = country.replacingOccurrences(of: " ", with: "")
            countriesString = countriesString.replacingOccurrences(of: ",", with: "")

            var countries = [String]()
            while !countriesString.isEmpty {
                let trimString = String(countriesString.prefix(2))
                countries.append(trimString)
                if let range = countriesString.range(of: trimString) {
                    countriesString.removeSubrange(range)
                }
            }
            for item in countries {
                newList.append(contentsOf: completer.results.map {
                    if $0.subtitle.lowercased().contains(getCountryName(countryCode: item).lowercased()) {
                        return SearchAutoComplete.Address(address: $0)
                    } else {
                        return .none
                    }
                })
            }
        } else {
            newList.append(contentsOf: completer.results.map {SearchAutoComplete.Address(address: $0)})
        }
        searchResult = newList
        
        // Auto complete for locationSearchTextField
        searchAddressResult.removeAll()
        for item in searchResult where item.type == "address" {
            searchAddressResult.append(item.value)
        }
        if let string = locationSearchTextField.text, locationSearchTextField.isEditing {
            autoCompleteText(in: locationSearchTextField, searchResult: searchAddressResult, using: string.capitalized)
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func getCountryName(countryCode: String) -> String {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode) ?? countryCode
    }
}

extension SearchInputViewController: SearchInputDataSourceDelegate {
    
    func didSelect(result: SearchAutoComplete) {
        switch result {
        case .none:
            break
        case .NearMe:
            locationSearchTextField.text = kNearMeTitle
            searchInputAutocompleteModelView.set(isNearMeSearch: true)
            searchResult = []
        case .Address(let address):
            selectedAddress = "\(address.title), \(address.subtitle)"
            isSelectedAddress = true
            locationSearchTextField.setBorderWith(width: 0, cornerRadius: 8, borderColor: .clear)
            let composedAdd = "\(address.title), \(address.subtitle)"
            locationSearchTextField.text = composedAdd
            searchInputAutocompleteModelView.set(address: composedAdd)
            searchResult = []
        case .Code(let code):
            specialtySearchTextField.text = code.longLbl
            searchInputAutocompleteModelView.set(code: code)
            locationSearchTextField.becomeFirstResponder()
        case .Individual(let individual):
            performSegue(withIdentifier: "showFullCardVC", sender: individual)
        }
    }
}

extension CLPlacemark {
    /// street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    
    /// // eg. 1
    var streetNumber: String? { subThoroughfare }
    
    /// city, eg. Cupertino
    var city: String? { locality }
    
    /// neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    
    /// state, eg. CA
    var state: String? { administrativeArea }
    
    /// county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    
    /// zip code, eg. 95014
    var zipCode: String? { postalCode }
    
    /// postal address formatted
    @available(iOS 11.0, *)
    var postalCountryFormatted: String? {
        guard let postalAddress = postalAddress else { return nil }
        return postalAddress.country
    }
}

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}
