//
//  SearchResultViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit

class SearchResultViewController: UIViewController, ViewDesign {
    var theme: OKThemeConfigure?

    var resultNavigationVC: UINavigationController!
    var data: SearchData?
    
    var result: [ActivityResult] {
        return data?.result ?? []
    }
    
    var sort = SearchResultSortViewController.SortBy.relevance {
        didSet {
            sortResultBy(sort: sort)
        }
    }
    
    private var searchResultViewModel: SearchResultViewModel?
    
    @IBOutlet weak var topLabelsWrapper: UIStackView!
    @IBOutlet weak var topInputWrapper: UIStackView!
    @IBOutlet weak var topInputTextField: UITextField!
    @IBOutlet weak var searchButton: BaseButton!
    
    @IBOutlet weak var bodyWrapper: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var firstSeparatorView: UIView!
    @IBOutlet weak var secondSeparatorView: UIView!
    @IBOutlet weak var criteriaLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var displayModeSegmentView: SegmentControlView!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var activityCountLabel: UILabel!
    @IBOutlet weak var sortButtonWrapper: BaseView!
    @IBOutlet weak var sortButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topInputTextField.delegate = self
        
        if let search = data {
            searchResultViewModel = SearchResultViewModel(webservices: OKHCPSearchWebServices(apiKey: OKManager.shared.apiKey.orEmpty,
                                                                                              manager: OKServiceManager.shared),
                                                          search: search)
        }
        
        if let unwrap = data {
            layoutWith(searchData: unwrap)
        }
        
        if let theme = theme {
            layoutWith(theme: theme)
        }
        
        sort = .relevance
        
        // Initialize search
        performSearch()
    }
    
    private func performSearch() {
        searchResultViewModel?.showLoadingOn(view: bodyWrapper)
        searchResultViewModel?.performSearch(config: OKManager.shared, completionHandler: {[weak self] (result, error) in
            guard let strongSelf = self else {return}
            if let result = result {
                strongSelf.data?.change(result: result)
                strongSelf.reloadWith(data: strongSelf.data!)
                strongSelf.searchResultViewModel?.hideLoading()
            } else {
                print(error)
            }
        })
    }
    
    func reloadWith(data: SearchData) {
        layoutWith(searchData: data)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for resultChildVC in self.resultNavigationVC.viewControllers {
                if let resultVC = resultChildVC as? SortableResultList {
                    resultVC.reloadWith(data: data.result)
                }
            }
        }
    }
    
    func layoutWith(searchData: SearchData) {
        activityCountLabel.text = "\(searchData.result.count)"
        criteriaLabel.text = searchData.codes?.first?.longLbl ?? searchData.criteria
        // Display map by default if the user active near me search at home screen
        if searchData.isQuickNearMeSearch == true {
            topInputWrapper.isHidden = false
            topLabelsWrapper.isHidden = true
            if let viewMapVC = ViewControllers.viewControllerWith(identity: .searchResultMap) as? SearchResultMapViewController {
                viewMapVC.result = result
                viewMapVC.theme = theme
                displayModeSegmentView.selectedIndex = 1
                resultNavigationVC.pushViewController(viewMapVC, animated: false)
            }
        } else {
            topInputWrapper.isHidden = true
            topLabelsWrapper.isHidden = false
        }
        
        if searchData.isNearMeSearch == true {
            addressLabel.text = kNearMeTitle
        } else {
            addressLabel.text = searchData.address
        }
    }
    
    func layoutWith(theme: OKThemeConfigure) {
        resultsLabel.text = "onekey_sdk_results_label".localized
        
        // Fonts
        resultsLabel.font = theme.searchResultTotalFont
        criteriaLabel.font = theme.searchResultTitleFont
        addressLabel.font = theme.smallFont
        activityCountLabel.font = theme.smallFont
        topInputTextField.font = theme.searchInputFont
        
        // Colors
        resultsLabel.textColor = theme.darkColor
        sortButton.backgroundColor = theme.secondaryColor
        activityCountLabel.textColor = theme.primaryColor
        criteriaLabel.textColor = theme.darkColor
        addressLabel.textColor = theme.greyColor
        backButton.tintColor = theme.darkColor
        firstSeparatorView.backgroundColor = theme.greyLighterColor
        secondSeparatorView.backgroundColor = theme.greyLighterColor
        topInputTextField.textColor = theme.darkColor
        topInputTextField.attributedPlaceholder = NSAttributedString(string: "onekey_sdk_find_healthcare_professional".localized,
                                                                     attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        
        displayModeSegmentView.items = [SegmentControlModel(icon: UIImage.OKImageWith(name: "list-view"),
                                                            title: "onekey_sdk_list_label".localized,
                                                              selectedBackgroundColor: theme.primaryColor,
                                                              selectedForcegroundColor: UIColor.white,
                                                              nonSelectedBackgroundColor: UIColor.white,
                                                              nonSelectedForcegroundColor: UIColor.darkGray),
                                        SegmentControlModel(icon: UIImage.OKImageWith(name: "map-view"),
                                                            title: "onekey_sdk_map_label".localized,
                                                              selectedBackgroundColor: theme.primaryColor,
                                                              selectedForcegroundColor: UIColor.white,
                                                              nonSelectedBackgroundColor: UIColor.white,
                                                              nonSelectedForcegroundColor: UIColor.darkGray)]
        displayModeSegmentView.selectedIndex = 0
        displayModeSegmentView.delegate = self
    }

    @IBAction func onBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        performSegue(withIdentifier: "showSearchInputVC", sender: SearchData(criteria: nil,
                                                                                  codes: nil,
                                                                                  address: nil,
                                                                                  isNearMeSearch: true,
                                                                                  isQuickNearMeSearch: true))
    }
    
    func sortResultBy(sort: SearchResultSortViewController.SortBy) {
        searchResultViewModel?.sortResultBy(sort, {[weak self] (data) in
            guard let strongSelf = self else {return}
            strongSelf.data = data
            strongSelf.reloadWith(data: data)
        })
    }
    
    // MARK: - Navigation

    @IBAction func unwindToSearchResultViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "embedResultNavicationVC":
                if let desVC = segue.destination as? UINavigationController {
                    resultNavigationVC = desVC
                    resultNavigationVC.delegate = self
                }
            case "showResultSortVC":
                if let desVC = segue.destination as? SearchResultSortViewController {
                    desVC.sort = sort
                }
            case "showFullCardVC":
                if let desVC = segue.destination as? HCPFullCardViewController {
                    desVC.theme = theme
                    if let activity = sender as? ActivityResult {
                        desVC.activityID = activity.activity.id
                    }
                }
            case "showSearchInputVC":
                if let desVC = segue.destination as? SearchInputViewController {
                    desVC.theme = theme
                    if let data = sender as? SearchData {
                        desVC.data = data
                    }
                }
            default:
                return
            }
        }
    }

}

extension SearchResultViewController: SegmentControlViewProtocol {
    func didSelect(item: SegmentControlItem) {
        displayModeSegmentView.selectedIndex = item.index
        switch item.index {
        case 0:
            if let resultListVC = resultNavigationVC.viewControllers.first as? SearchResultListViewController {
                resultListVC.result = result
                resultListVC.theme = theme
            }
            resultNavigationVC.popToRootViewController(animated: true)
        case 1:
            if let viewMapVC = ViewControllers.viewControllerWith(identity: .searchResultMap) as? SearchResultMapViewController {
                viewMapVC.result = result
                viewMapVC.theme = theme
                resultNavigationVC.pushViewController(viewMapVC, animated: true)
            }
        default:
            return
        }
    }
}

extension SearchResultViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let designAbleVC = viewController as? ViewDesign {
            var editableVC = designAbleVC
            editableVC.theme = theme
            if let theme = theme {
                editableVC.layoutWith(theme: theme)
            }
        }
        
        if let activityListHandler = viewController as? ActivityListHandler {
            var editableVC = activityListHandler
            editableVC.delegate = self
        }
    }
}

extension SearchResultViewController: ActivityHandler {
    func didSelect(activity: ActivityResult) {
        performSegue(withIdentifier: "showFullCardVC", sender: activity)
    }
}

extension SearchResultViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == topInputTextField {
            performSegue(withIdentifier: "showSearchInputVC", sender: SearchData(criteria: nil,
                                                                                      codes: nil,
                                                                                      address: nil,
                                                                                      isNearMeSearch: true,
                                                                                      isQuickNearMeSearch: true))
        }
    }
}
