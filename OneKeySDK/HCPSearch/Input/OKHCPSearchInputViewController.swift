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
    
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var categorySearchTextField: UITextField!
    @IBOutlet weak var locationSearchTextField: UITextField!
    @IBOutlet weak var searchBtn: OKBaseButton!
    
    
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

    func layoutWith(theme: OKThemeConfigure) {
        searchBtn.backgroundColor = theme.primaryColor
        categorySearchTextField.font = theme.defaultFont
        locationSearchTextField.font = theme.defaultFont
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        webService.searchHCPWith(input: SearchHCPInput()) {[weak self] (result, error) in
            guard let strongSelf = self, let unwrapResult = result else {return}
            strongSelf.performSegue(withIdentifier: "showResultVC", sender: unwrapResult)
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
                   let result = sender as? [SearchResultModel] {
                    desVC.result = result
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
                                iconImage: (UIImage(named: "ic-search-me", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate))!,
                                title: "Near me")
            default:
                cell.configWith(theme: theme,
                                iconImage: (UIImage(named: "ic-search-marker", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate))!,
                                title: searchResult[indexPath.row].title)
            }
        }
        return cell
    }
    
}

// MARK: Textfield delegate
extension OKHCPSearchInputViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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
