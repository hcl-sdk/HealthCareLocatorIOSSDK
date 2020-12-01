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
    
    let historyViewModel = OKSearchHistoryViewModel()
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
        searchBtn.backgroundColor = theme.primaryColor
        searchTextField.font = theme.defaultFont
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
        }
    }
    
    func shouldRemoveActivityAt(indexPath: IndexPath) {
        
    }
    
    func shouldRemoveSearchAt(indexPath: IndexPath) {
        
    }
}
