//
//  OKHCPSearchViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/6/20.
//

import UIKit

/**
 The root UI to  begin the whole search process internally
 - Example:  This show how to use the **OKHCPSearchNavigationViewController**
 
 ````
    let manager = OKManager.share
    let searchHCPVC = manager.getHCPSearchViewController()
    present(searchHCPVC, animated: true)
 ````
 - Note:
 The user interface could be configure through settings of *theme* and *icons* while the initilazing the **OKManager** instance
 - Important:
 Should create the *OKHCPSearchNavigationViewController* through *OKManager* instead of using it constructor directly
 */
public class OKHCPSearchNavigationViewController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
        layoutWith(theme: theme)
    }
    
    func configure(search: OKSearchConfigure) {
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
            let resultVC = ViewControllers.viewControllerWith(identity: .searchResult) as! SearchResultViewController
            resultVC.data = SearchData(criteria: nil,
                                       codes: search.favourites.map {Code(id: $0, longLbl: nil)},
                                       mode: .quickNearMeSearch)
            resultVC.shouldHideBackButton = true
            setViewControllers([resultVC], animated: false)
        }
    }
    
    private func layoutCompactMode(theme: OKThemeConfigure, icons: OKIconsConfigure) {
        if viewControllers.count <= 1 {
            DispatchQueue.main.async {
                let compactHomeVC = ViewControllers.viewControllerWith(identity: .home) as! SearchHomeViewController
                self.setViewControllers([compactHomeVC], animated: false)
            }
        }
    }
    
    private func layoutFullMode(theme: OKThemeConfigure, icons: OKIconsConfigure) {
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

extension OKHCPSearchNavigationViewController: ViewDesign {
    func layoutWith(theme: OKThemeConfigure) {
        navigationBar.barTintColor = theme.primaryColor
    }
}
