//
//  OKHCPSearchHomeFullViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit

class OKHCPSearchHomeFullViewController: UIViewController, OKViewDesign {
    var theme: OKThemeConfigure?
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: OKBaseButton!
    @IBOutlet weak var historyTableView: UITableView!
    
    let historyViewModel = OKSearchHistoryViewModel(webService: MockOKHCPSearchWebServices())
    
    var tableViewDataSource: OKSearchHistoryDataSource!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        tableViewDataSource = OKSearchHistoryDataSource(tableView: historyTableView)
        tableViewDataSource.delegate = self
        if let theme = theme {
            layoutWith(theme: theme)
        }
        
        historyViewModel.fetchHistory {[weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case .success(let section):
                strongSelf.tableViewDataSource.reloadWith(data: section)
            case .failure:
                break
            }
        }
    }
    
    func layoutWith(theme: OKThemeConfigure) {
        // Colors
        view.backgroundColor = theme.viewBackgroundColor
        searchBtn.backgroundColor = theme.primaryColor
        searchTextField.textColor = theme.darkColor
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Find Healthcare Professional",
                                                                   attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        // Fonts
        searchTextField.font = theme.searchInputFont
        tableViewDataSource.layoutWith(theme: theme)
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        performSegue(withIdentifier: "showSearchInputVC", sender: searchTextField.text)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showSearchInputVC":
                if let desVC = segue.destination as? OKHCPSearchInputViewController {
                    desVC.theme = theme
                }
            case "showFullCardVC":
                if let desVC = segue.destination as? OKHCPFullCardViewController,
                   let activity = sender as? Activity {
                    desVC.theme = theme
                    desVC.activity = activity
                }
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

extension OKHCPSearchHomeFullViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        performSegue(withIdentifier: "showSearchInputVC", sender: nil)
    }
}

extension OKHCPSearchHomeFullViewController: OKSearchHistoryDataSourceDelegate {
    
    func didSelect(activity: Activity) {
        performSegue(withIdentifier: "showFullCardVC", sender: activity)
    }
    
    func didSelect(search: OKHCPLastSearch) {
        if let selected = search.selected {
            performSegue(withIdentifier: "showFullCardVC", sender: selected)
        } else {
            let input = search.getInput()
            historyViewModel.performSearchingWith(input: input,
                                                  location: nil) {[weak self] (result) in
                guard let strongSelf = self else {return}
                switch result {
                case .success(let activities):
                    strongSelf.performSegue(withIdentifier: "showResultVC", sender: OKHCPSearchData(input: input, result: activities))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func shouldRemoveActivityAt(indexPath: IndexPath) {
        
    }
    
    func shouldRemoveSearchAt(indexPath: IndexPath) {
        
    }
}
