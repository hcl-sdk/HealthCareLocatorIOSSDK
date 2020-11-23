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
    var result: [Activity] = []
    
    @IBOutlet weak var displayModeSegmentView: OKSegmentControlView!
    @IBOutlet weak var activityCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityCountLabel.text = "\(result.count)"
        if let theme = theme {
            layoutWith(theme: theme)
        }

        // NOTE: Display map by default for demo
        if let viewMapVC = UIStoryboard(name: "HCPSearch", bundle: Bundle.internalBundle()).instantiateViewController(withIdentifier: "OKHCPSearchResultMapViewController") as? OKHCPSearchResultMapViewController {
            viewMapVC.result = result
            viewMapVC.theme = theme
            resultNavigationVC.pushViewController(viewMapVC, animated: false)
        }
    }
    
    func layoutWith(theme: OKThemeConfigure) {
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
        displayModeSegmentView.selectedIndex = 1
        displayModeSegmentView.delegate = self
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
