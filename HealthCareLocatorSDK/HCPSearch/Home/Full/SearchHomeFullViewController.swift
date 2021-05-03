//
//  SearchHomeFullViewController.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit
import RxSwift

class SearchHomeFullViewController: UIViewController, ViewDesign {
    private let viewModel = HomeFullViewModel()
    private let historyViewModel = SearchHistoryViewModel(webService: HCLHCPSearchWebServices(manager: HCLServiceManager.shared))
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: BaseButton!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var bodyWrapperView: UIView!
    @IBOutlet weak var historyTableView: UITableView!
        
    var tableViewDataSource: SearchHistoryDataSource!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        tableViewDataSource = SearchHistoryDataSource(tableView: historyTableView)
        tableViewDataSource.delegate = self
        layoutWith(theme: theme, icons: icons)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historyViewModel.showLoadingOn(view: bodyWrapperView)
        historyViewModel.fetchHistory(config: HCLManager.shared,
                                      lastSearches: AppConfigure.getLastSearchesHistory(),
                                      lastHCPs: AppConfigure.getLastHCPsConsulted()).subscribe({[weak self] result in
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
    
    func layoutWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        viewModel.layout(view: self, with: theme, icons: icons)
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
                break
            case "showFullCardVC":
                if let desVC = segue.destination as? HCPFullCardViewController,
                   let activity = sender as? Activity {
                    desVC.activityID = activity.id
                }
            case "showResultVC":
                if let desVC = segue.destination as? SearchResultViewController {
                    if let data = sender as? SearchDataCore {
                        desVC.data = SearchData.from(core: data)
                    } else if let search = sender as? SearchData {
                        desVC.data = search
                    } else {
                        desVC.data = SearchData(criteria: nil,
                                                codes: nil,
                                                mode: .nearMeSearch)
                    }
                }
            default:
                return
            }
        }
    }
    
}

extension SearchHomeFullViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        performSegue(withIdentifier: "showSearchInputVC", sender: nil)
    }
}

extension SearchHomeFullViewController: SearchHistoryDataSourceDelegate {
    
    func didSelect(activity: Activity) {
        performSegue(withIdentifier: "showFullCardVC", sender: activity)
    }
    
    func didSelect(search: LastSearch) {
        performSegue(withIdentifier: "showResultVC", sender: search.search)
    }
    
    func didSelectNearMeSearch() {
        let searchData = SearchData(criteria: nil,
                                    codes: [],
                                    mode: .quickNearMeSearch)
        AppConfigure.save(search: searchData)
        performSegue(withIdentifier: "showResultVC", sender: searchData)
    }
    
    func shouldRemoveActivityAt(index: Int) {
        AppConfigure.removeActivityHistoryAt(index: index)
    }
    
    func shouldRemoveSearchAt(index: Int) {
        AppConfigure.removeSearchHistoryAt(index: index)
    }
}
