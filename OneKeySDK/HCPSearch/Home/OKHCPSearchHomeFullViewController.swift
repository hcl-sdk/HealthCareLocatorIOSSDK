//
//  OKHCPSearchHomeFullViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit
import RxSwift

class OKHCPSearchHomeFullViewController: UIViewController, OKViewDesign {
    var theme: OKThemeConfigure?
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: OKBaseButton!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var bodyWrapperView: UIView!
    @IBOutlet weak var historyTableView: UITableView!
    
    let historyViewModel = OKSearchHistoryViewModel(webService: MockOKHCPSearchWebServices())
    
    var tableViewDataSource: OKSearchHistoryDataSource!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        tableViewDataSource = OKSearchHistoryDataSource(tableView: historyTableView)
        tableViewDataSource.delegate = self
        if let theme = theme {
            layoutWith(theme: theme)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historyViewModel.showLoadingOn(view: bodyWrapperView)
        historyViewModel.fetchHistory().subscribe({[weak self] result in
            guard let strongSelf = self else {return}
            switch result {
            case .success(let sections):
                strongSelf.tableViewDataSource.reloadWith(data: sections)
            case .error(let error):
                // TODO: Handle error
                print(error)
            }
            strongSelf.historyViewModel.hideLoading()
        }).disposed(by: disposeBag)
    }
    
    func layoutWith(theme: OKThemeConfigure) {
        // Colors
        view.backgroundColor = theme.viewBkgColor
        separatorView.backgroundColor = theme.cardBorderColor
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
                    desVC.activityID = activity.id
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
        performSegue(withIdentifier: "showResultVC", sender: search.search)
    }
    
    func didSelectNearMeSearch() {
        let searchData = OKHCPSearchData(criteria: nil,
                                         code: nil,
                                         address: nil,
                                         isNearMeSearch: true,
                                         isQuickNearMeSearch: true)
        OKDatabase.save(search: searchData)
        performSegue(withIdentifier: "showResultVC", sender: searchData)
    }
    
    func shouldRemoveActivityAt(index: Int) {
        OKDatabase.removeActivityHistoryAt(index: index)
    }
    
    func shouldRemoveSearchAt(index: Int) {
        OKDatabase.removeSearchHistoryAt(index: index)
    }
}
