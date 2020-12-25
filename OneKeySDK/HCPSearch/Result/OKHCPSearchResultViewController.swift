//
//  OKHCPSearchResultViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit

class OKHCPSearchResultViewController: UIViewController, OKViewDesign {
    var theme: OKThemeConfigure?

    var resultNavigationVC: UINavigationController!
    var data: OKHCPSearchData?
    
    var result: [ActivityResult] {
        return data?.result ?? []
    }
    
    var sort = OKHCPSearchResultSortViewController.SortBy.relevance {
        didSet {
            sortResultBy(sort: sort)
        }
    }
    
    private var searchResultViewModel: SearchResultViewModel?
    
    @IBOutlet weak var topLabelsWrapper: UIStackView!
    @IBOutlet weak var topInputWrapper: UIStackView!
    @IBOutlet weak var topInputTextField: UITextField!
    @IBOutlet weak var searchButton: OKBaseButton!
    
    @IBOutlet weak var bodyWrapper: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var firstSeparatorView: UIView!
    @IBOutlet weak var secondSeparatorView: UIView!
    @IBOutlet weak var criteriaLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var displayModeSegmentView: OKSegmentControlView!
    @IBOutlet weak var activityCountLabel: UILabel!
    @IBOutlet weak var sortButtonWrapper: OKBaseView!
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
        searchResultViewModel?.performSearch({[weak self] (result, error) in
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
    
    func reloadWith(data: OKHCPSearchData) {
        layoutWith(searchData: data)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for resultChildVC in self.resultNavigationVC.viewControllers {
                if let resultVC = resultChildVC as? OkSortableResultList {
                    resultVC.reloadWith(data: data.result)
                }
            }
        }
    }
    
    func layoutWith(searchData: OKHCPSearchData) {
        activityCountLabel.text = "\(searchData.result.count)"
        criteriaLabel.text = searchData.codes?.first?.longLbl ?? searchData.criteria
        // Display map by default if the user active near me search at home screen
        if searchData.isQuickNearMeSearch == true {
            topInputWrapper.isHidden = false
            topLabelsWrapper.isHidden = true
            if let viewMapVC = UIStoryboard(name: "HCPSearch", bundle: Bundle.internalBundle()).instantiateViewController(withIdentifier: "OKHCPSearchResultMapViewController") as? OKHCPSearchResultMapViewController {
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
        // Fonts
        criteriaLabel.font = theme.searchResultTitleFont
        addressLabel.font = theme.smallFont
        activityCountLabel.font = theme.smallFont
        topInputTextField.font = theme.searchInputFont
        
        // Colors
        sortButton.backgroundColor = theme.secondaryColor
        activityCountLabel.textColor = theme.primaryColor
        criteriaLabel.textColor = theme.darkColor
        addressLabel.textColor = theme.greyColor
        backButton.tintColor = theme.darkColor
        firstSeparatorView.backgroundColor = theme.greyLighterColor
        secondSeparatorView.backgroundColor = theme.greyLighterColor
        topInputTextField.textColor = theme.darkColor
        topInputTextField.attributedPlaceholder = NSAttributedString(string: "Find Healthcare Professional",
                                                                     attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        
        displayModeSegmentView.items = [OkSegmentControlModel(icon: UIImage.OKImageWith(name: "list-view"),
                                                              title: "List",
                                                              selectedBackgroundColor: theme.primaryColor,
                                                              selectedForcegroundColor: UIColor.white,
                                                              nonSelectedBackgroundColor: UIColor.white,
                                                              nonSelectedForcegroundColor: UIColor.darkGray),
                                        OkSegmentControlModel(icon: UIImage.OKImageWith(name: "map-view"),
                                                              title: "Map",
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
        performSegue(withIdentifier: "showSearchInputVC", sender: OKHCPSearchData(criteria: nil,
                                                                                  codes: nil,
                                                                                  address: nil,
                                                                                  isNearMeSearch: true,
                                                                                  isQuickNearMeSearch: true))
    }
    
    func sortResultBy(sort: OKHCPSearchResultSortViewController.SortBy) {
        searchResultViewModel?.sortResultBy(sort, {[weak self] (data) in
            guard let strongSelf = self else {return}
            strongSelf.data = data
            strongSelf.reloadWith(data: data)
        })
    }
    
    // MARK: - Navigation

    @IBAction func unwindToOKHCPSearchResultViewController(_ unwindSegue: UIStoryboardSegue) {
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
                if let desVC = segue.destination as? OKHCPSearchResultSortViewController {
                    desVC.sort = sort
                }
            case "showFullCardVC":
                if let desVC = segue.destination as? OKHCPFullCardViewController {
                    desVC.theme = theme
                    if let activity = sender as? ActivityResult {
                        desVC.activityID = activity.activity.id
                    }
                }
            case "showSearchInputVC":
                if let desVC = segue.destination as? OKHCPSearchInputViewController {
                    desVC.theme = theme
                    if let data = sender as? OKHCPSearchData {
                        desVC.data = data
                    }
                }
            default:
                return
            }
        }
    }

}

extension OKHCPSearchResultViewController: OKSegmentControlViewProtocol {
    func didSelect(item: OkSegmentControlItem) {
        displayModeSegmentView.selectedIndex = item.index
        switch item.index {
        case 0:
            if let resultListVC = resultNavigationVC.viewControllers.first as? OKHCPSearchResultListViewController {
                resultListVC.result = result
                resultListVC.theme = theme
            }
            resultNavigationVC.popToRootViewController(animated: true)
        case 1:
            if let viewMapVC = UIStoryboard(name: "HCPSearch", bundle: Bundle.internalBundle()).instantiateViewController(withIdentifier: "OKHCPSearchResultMapViewController") as? OKHCPSearchResultMapViewController {
                viewMapVC.result = result
                viewMapVC.theme = theme
                resultNavigationVC.pushViewController(viewMapVC, animated: true)
            }
        default:
            return
        }
    }
}

extension OKHCPSearchResultViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let designAbleVC = viewController as? OKViewDesign {
            var editableVC = designAbleVC
            editableVC.theme = theme
            if let theme = theme {
                editableVC.layoutWith(theme: theme)
            }
        }
        
        if let activityList = viewController as? OKActivityList {
            var editableVC = activityList
            editableVC.delegate = self
        }
    }
}

extension OKHCPSearchResultViewController: OKActivityHandler {
    func didSelect(activity: ActivityResult) {
        performSegue(withIdentifier: "showFullCardVC", sender: activity)
    }
}

extension OKHCPSearchResultViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == topInputTextField {
            performSegue(withIdentifier: "showSearchInputVC", sender: OKHCPSearchData(criteria: nil,
                                                                                      codes: nil,
                                                                                      address: nil,
                                                                                      isNearMeSearch: true,
                                                                                      isQuickNearMeSearch: true))
        }
    }
}
