//
//  OKHCPSearchViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/6/20.
//

import UIKit

/**
 The instance of the HCP search navigation controller, by default this instance process the whole search process internally, implement *OKManagerDelegateProtocol* to listen for its callbacks
 - Example:  This show how to use the **OKHCPSearchNavigationViewController**
 
 ````
    let manager = OKManager.share
    manager.delegate = self
    let searchHCPVC = manager.OKHCPSearchNavigationViewController()
    present(searchHCPVC, animated: true)
 ````
 - Note:
 Should create the *OKHCPSearchNavigationViewController* through *OKManager* instead of using it constructor directly
 */
public class OKHCPSearchNavigationViewController: UINavigationController {

    /**
     The theme configuration object for dynamic UI displaying dependence on container app business
     */
    public var theme: OKThemeConfigure? {
        didSet {
            guard let theme = self.theme else {return}
            if isViewLoaded {
                layoutWith(theme: theme)
            }
        }
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(configure: OKSearchConfigure, fullMode: Bool) {
        switch configure.entry {
        case .home,
             .none:
            if fullMode {
                let fullHomeVC = UIStoryboard(name: "HCPSearch", bundle: Bundle.internalBundle()).instantiateViewController(withIdentifier: "OKHCPSearchHomeFullViewController") as! OKHCPSearchHomeFullViewController
                super.init(rootViewController: fullHomeVC)
            } else {
                let compactHomeVC = UIStoryboard(name: "HCPSearch", bundle: Bundle.internalBundle()).instantiateViewController(withIdentifier: "OKHCPSearchHomeViewController") as! OKHCPSearchHomeViewController
                super.init(rootViewController: compactHomeVC)
            }
        case .nearMe:
            let resultVC = UIStoryboard(name: "HCPSearch", bundle: Bundle.internalBundle()).instantiateViewController(withIdentifier: "OKHCPSearchResultViewController") as! OKHCPSearchResultViewController
            resultVC.data = OKHCPSearchData(criteria: nil,
                                            codes: configure.favourites.map {Code(id: $0, longLbl: nil)},
                                            address: nil,
                                            isNearMeSearch: true,
                                            isQuickNearMeSearch: true)
            super.init(rootViewController: resultVC)
        }
        
        isNavigationBarHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        guard let theme = theme else {return}
        layoutWith(theme: theme)
    }
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let viewController = viewController as? OKViewDesign {
            var editableVC = viewController
            editableVC.theme = theme
            super.pushViewController((editableVC as! UIViewController), animated: animated)
        } else {
            super.pushViewController(viewController, animated: animated)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OKHCPSearchNavigationViewController: OKViewDesign {
    func layoutWith(theme: OKThemeConfigure) {
        navigationBar.barTintColor = theme.primaryColor
        for viewController in viewControllers {
            if let designAbleVC = viewController as? OKViewDesign {
                var editableVC = designAbleVC
                editableVC.theme = theme
            }
        }
    }
}
