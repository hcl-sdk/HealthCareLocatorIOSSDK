//
//  OKHCPSearchViewController.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/6/20.
//

import UIKit

/**
 The root UI to  begin the whole search process internally
 - Example:  This show how to use the **HCLHCPSearchNavigationViewController**
 
 ````
    let manager = HCLManager.share
    let searchHCPVC = manager.getHCPSearchViewController()
    present(searchHCPVC, animated: true)
 ````
 - Note:
 The user interface could be configure through settings of *theme* and *icons* while the initilazing the **HCLManager** instance
 - Important:
 Should create the *HCLHCPSearchNavigationViewController* through *HCLManager* instead of using it constructor directly
 */
public class HCLHCPSearchNavigationViewController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
        layoutWith(theme: theme)
    }
    
    func configure(search: HCLSearchConfigure) {
        switch search.entry {
        case .home,
             .none:
            let compactHomeVC = ViewControllers.viewControllerWith(identity: .home) as! SearchHomeViewController
            compactHomeVC.hideBodyView(isHidden: true)
            setViewControllers([compactHomeVC], animated: false)
            LocationManager.shared.requestAuthorization {[weak self] (status) in
                guard let strongSelf = self else {return}
                let icons = strongSelf.icons
                let theme = strongSelf.theme
                switch status {
                case .denied, .notDetermined, .restricted:
                    if AppConfigure.getLastSearchesHistory().count == 0 &&
                        AppConfigure.getLastHCPsConsulted().count == 0 {
                        strongSelf.layoutCompactMode(theme: theme, icons: icons)
                    } else {
                        strongSelf.layoutFullMode(theme: theme, icons: icons)
                    }
                default:
                    strongSelf.layoutFullMode(theme: theme, icons: icons)
                }
            }
        case .nearMe:
            let compactHomeVC = ViewControllers.viewControllerWith(identity: .home) as! SearchHomeViewController
            let resultVC = ViewControllers.viewControllerWith(identity: .searchResult) as! SearchResultViewController
            resultVC.data = SearchData(criteria: nil,
                                       codes: [Code(id: search.speciality, longLbl: nil)],
                                       mode: .nearMeSearch)
            setViewControllers([compactHomeVC, resultVC], animated: false)
        }
    }
    
    private func layoutCompactMode(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        if viewControllers.count <= 1 {
            DispatchQueue.main.async {
                let compactHomeVC = ViewControllers.viewControllerWith(identity: .home) as! SearchHomeViewController
                self.setViewControllers([compactHomeVC], animated: false)
            }
        }
    }
    
    private func layoutFullMode(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        if viewControllers.count <= 1 {
            DispatchQueue.main.async {
                let fullHomeVC = ViewControllers.viewControllerWith(identity: .homeFull) as! SearchHomeFullViewController
                self.setViewControllers([fullHomeVC], animated: false)
            }
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

extension HCLHCPSearchNavigationViewController: ViewDesign {
    func layoutWith(theme: HCLThemeConfigure) {
        navigationBar.barTintColor = theme.primaryColor
    }
}
