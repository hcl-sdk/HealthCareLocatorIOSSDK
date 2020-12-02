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
    
    var result: [Activity] {
        return data?.result ?? []
    }
    
    var sort = OKHCPSearchResultSortViewController.SortBy.relevance {
        didSet {
            sortResultBy(sort: sort)
        }
    }
    
    @IBOutlet weak var criteriaLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var displayModeSegmentView: OKSegmentControlView!
    @IBOutlet weak var activityCountLabel: UILabel!
    @IBOutlet weak var sortButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let unwrap = data {
            layoutWith(searchData: unwrap)
        }
        
        if let theme = theme {
            layoutWith(theme: theme)
        }
        
        sort = .relevance
    }
    
    func layoutWith(searchData: OKHCPSearchData) {
        activityCountLabel.text = "\(searchData.result.count)"
        criteriaLabel.text = searchData.input.criteriaText
        addressLabel.text = searchData.input.placeAddressText
    }
    
    func layoutWith(theme: OKThemeConfigure) {
        sortButton.tintColor = theme.secondaryColor
        criteriaLabel.font = theme.title2Font
        addressLabel.font = theme.smallFont
        activityCountLabel.textColor = theme.primaryColor
        displayModeSegmentView.items = [OkSegmentControlModel(icon: UIImage.OKImageWith(name: "ic-list"),
                                                              title: "List View",
                                                              selectedBackgroundColor: theme.primaryColor,
                                                              selectedForcegroundColor: UIColor.white,
                                                              nonSelectedBackgroundColor: UIColor.white,
                                                              nonSelectedForcegroundColor: UIColor.darkGray),
                                        OkSegmentControlModel(icon: UIImage.OKImageWith(name: "ic-map"),
                                                              title: "Map View",
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
    
    
    func sortResultBy(sort: OKHCPSearchResultSortViewController.SortBy) {
        if let resultList = data?.result, let input = data?.input {
            var newList = resultList
            switch sort {
            case .name:
                newList.sort { (lhs, rhs) -> Bool in
                    return lhs.title.label < rhs.title.label
                }
            case .distance:
                break
            case .relevance:
                break
            }
            data = OKHCPSearchData(input: input, result: newList)
            for resultChildVC in resultNavigationVC.viewControllers {
                if let resultVC = resultChildVC as? OkSortableResultList {
                    resultVC.reloadWith(data: newList)
                }
            }
        }
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
                    if let activity = sender as? Activity {
                        desVC.activity = activity
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
        }
        
        if let activityList = viewController as? OKActivityList {
            var editableVC = activityList
            editableVC.delegate = self
        }
    }
}

extension OKHCPSearchResultViewController: OKActivityHandler {
    func didSelect(activity: Activity) {
        performSegue(withIdentifier: "showFullCardVC", sender: activity)
    }
}
