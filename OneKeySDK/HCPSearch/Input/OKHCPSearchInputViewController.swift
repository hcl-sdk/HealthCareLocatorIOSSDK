//
//  OKHCPSearchInputViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit
import MapKit

class OKHCPSearchInputViewController: UIViewController, OKViewDesign {
    
    var theme: OKThemeConfigure?

    private var webService: OKHCPSearchWebServicesProtocol = MockOKHCPSearchWebServices()
        
    private let searchCompleter = MKLocalSearchCompleter()
    private var searchResult = [MKLocalSearchCompletion]() {
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
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        searchResultTableView.tableFooterView = UIView()
        categorySearchTextField.delegate = self
        locationSearchTextField.delegate = self
        if let theme = theme {
            layoutWith(theme: theme)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categorySearchTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(false)
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
        let isPlaceAddressValid = validator.isPlaceAddressValid(placeAddressText: locationSearchTextField.text)
        
        if !isCriteriaValid {
            categorySearchTextField.setBorderWith(width: 2, cornerRadius: 8, borderColor: UIColor.red)
        }
        
        if !isPlaceAddressValid {
            locationSearchTextField.setBorderWith(width: 2, cornerRadius: 8, borderColor: UIColor.red)
        }
        
        if isCriteriaValid && isPlaceAddressValid {
            let searchInput = OKHCPSearchInput(criteriaText: categorySearchTextField.text,
                                             placeAddressText: locationSearchTextField.text)
            performSearchingWith(input: searchInput, location: nil)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func performSearchingWith(input: OKHCPSearchInput, location: CLLocationCoordinate2D?) {
        webService.searchHCPWith(input: input, manager: OKServiceManager.shared) {[weak self] (result, error) in
            guard let strongSelf = self else {return}
            if let error = error {
                
            } else if let unwrapResult = result {
                strongSelf.performSegue(withIdentifier: "showResultVC", sender: OKHCPSearchData(input: input,
                                                                                                result: unwrapResult))
            } else {
                
            }
        }
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return searchResult.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
        if let theme = theme {
            switch indexPath.section {
            case 0:
                cell.configWith(theme: theme,
                                iconImage: UIImage.OKImageWith(name: "geoloc")!,
                                title: kNearMeTitle)
            default:
                cell.configWith(theme: theme,
                                iconImage: UIImage.OKImageWith(name: "marker")!,
                                title: "\(searchResult[indexPath.row].title), \(searchResult[indexPath.row].subtitle)")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            locationSearchTextField.text = kNearMeTitle
            searchResult = []
            if let criteria = categorySearchTextField.text, !criteria.isEmpty {
                performSearchingWith(input: OKHCPSearchInput(criteriaText: criteria, placeAddressText: kNearMeTitle), location: nil)
            }
        case 1:
            let composedAdd = "\(searchResult[indexPath.row].title), \(searchResult[indexPath.row].subtitle)"
            locationSearchTextField.text = composedAdd
            searchResult = []
            if let criteria = categorySearchTextField.text, !criteria.isEmpty {
                performSearchingWith(input: OKHCPSearchInput(criteriaText: criteria, placeAddressText: composedAdd), location: nil)
            }
        default:
            return
        }
    }
}

// MARK: Textfield delegate
extension OKHCPSearchInputViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.setBorderWith(width: 0, cornerRadius: 8, borderColor: .clear)
        if textField == locationSearchTextField {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let searchText = text.replacingCharacters(in: textRange, with: string)
                searchCompleter.queryFragment = searchText
            }
        }
        
        return true
    }
}

// MARK: Place autocomplete delegate
extension OKHCPSearchInputViewController: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResult = completer.results
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
