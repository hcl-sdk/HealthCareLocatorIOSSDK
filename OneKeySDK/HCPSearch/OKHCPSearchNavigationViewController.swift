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
    public var theme: OKThemeConfigure?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if let viewController = viewControllers.first as? OKViewDesign,
           let theme = theme {
            viewController.config(theme: theme)
        }
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
    /**
     Setup theme object which will be used to apply for the whole HCP search process
     - Parameter theme: The theme configuration object for dynamic UI displaying
     */
    public func config(theme: OKThemeConfigure) {
        self.theme = theme
    }
}
