//
//  SearchViewController.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/11/20.
//

import UIKit
import OneKeySDK

class SearchViewController: UIViewController {
    
    @IBOutlet weak var wrapperView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get manager and assign the delegate to listen for search process events
        let shared = OKManager.shared
        shared.initialize(apiKey: "1")
        shared.configure(search: OKSearchConfigure(favourites: Specialities.allCases))
        shared.delegate = self
        // Get the initial HCP search instants
        let HCPSearchVC = OKManager.shared.getHCPSearchViewController(fullMode: AppSettings.fullHomeModeEnabled)
        let storedTheme = AppSettings.selectedTheme
        let theme = OKThemeConfigure(defaultFont: UIFont.from(core: storedTheme.defaultFont),
                                     titleMainFont: UIFont.from(core: storedTheme.titleMainFont),
                                     titleSecondaryFont: UIFont.from(core: storedTheme.titleSecondaryFont),
                                     searchResultTotalFont: UIFont.from(core: storedTheme.searchResultTotalFont),
                                     searchResultTitleFont: UIFont.from(core: storedTheme.searchResultTitleFont),
                                     resultTitleFont: UIFont.from(core: storedTheme.resultTitleFont),
                                     resultSubTitleFont: UIFont.from(core: storedTheme.resultSubTitleFont),
                                     profileTitleFont: UIFont.from(core: storedTheme.profileTitleFont),
                                     profileSubTitleFont: UIFont.from(core: storedTheme.profileSubTitleFont),
                                     profileTitleSectionFont: UIFont.from(core: storedTheme.profileTitleSectionFont),
                                     cardTitleFont: UIFont.from(core: storedTheme.cardTitleFont),
                                     modalTitleFont: UIFont.from(core: storedTheme.modalTitleFont),
                                     searchInputFont: UIFont.from(core: storedTheme.searchInputFont),
                                     sortCriteriaFont: UIFont.from(core: storedTheme.sortCriteriaFont),
                                     buttonFont: UIFont.from(core: storedTheme.buttonFont),
                                     smallFont: UIFont.from(core: storedTheme.smallFont),
                                     primaryColor: UIColor.init(hexString: storedTheme.primaryColor),
                                     secondaryColor: UIColor.init(hexString: storedTheme.secondaryColor),
                                     buttonBkgColor: UIColor.init(hexString: storedTheme.buttonBkgColor),
                                     buttonAcceptBkgColor: UIColor.init(hexString: storedTheme.buttonAcceptBkgColor),
                                     buttonDiscardBkgColor: UIColor.init(hexString: storedTheme.buttonDiscardBkgColor),
                                     buttonBorderColor: UIColor.init(hexString: storedTheme.buttonBorderColor),
                                     cardBorderColor: UIColor.init(hexString: storedTheme.cardBorderColor),
                                     markerColor: UIColor.init(hexString: storedTheme.markerColor),
                                     markerSelectedColor: UIColor.init(hexString: storedTheme.markerSelectedColor),
                                     viewBkgColor: UIColor.init(hexString: storedTheme.viewBkgColor),
                                     listBkgColor: UIColor.init(hexString: storedTheme.listBkgColor),
                                     voteUpColor: UIColor.init(hexString: storedTheme.voteUpColor),
                                     voteDownColor: UIColor.init(hexString: storedTheme.voteDownColor),
                                     darkColor: UIColor.init(hexString: storedTheme.darkColor),
                                     greyColor: UIColor.init(hexString: storedTheme.greyColor),
                                     greyDarkColor: UIColor.init(hexString: storedTheme.greyDarkColor),
                                     greyDarkerColor: UIColor.init(hexString: storedTheme.greyDarkerColor),
                                     greyLightColor: UIColor.init(hexString: storedTheme.greyLightColor),
                                     greyLighterColor: UIColor.init(hexString: storedTheme.greyLighterColor))
        HCPSearchVC.theme = theme
        setupSearchView(searchVC: HCPSearchVC)
    }
    
    private func setupSearchView(searchVC: OKHCPSearchNavigationViewController) {
        let searchView = searchVC.view!
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchVC.willMove(toParent: self)
        addChild(searchVC)
        wrapperView.addSubview(searchView)
        searchVC.didMove(toParent: self)
        wrapperView.addConstraints([NSLayoutConstraint(item: searchView, attribute: .top, relatedBy: .equal, toItem: wrapperView, attribute: .top, multiplier: 1, constant: 0),
                             NSLayoutConstraint(item: searchView, attribute: .left, relatedBy: .equal, toItem: wrapperView, attribute: .left, multiplier: 1, constant: 0),
                             NSLayoutConstraint(item: searchView, attribute: .bottom, relatedBy: .equal, toItem: wrapperView, attribute: .bottom, multiplier: 1, constant: 0),
                             NSLayoutConstraint(item: searchView, attribute: .right, relatedBy: .equal, toItem: wrapperView, attribute: .right, multiplier: 1, constant: 0)])
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


extension SearchViewController: OkManagerDelegate {
    func HCPSearchWasCancelled() {
        for childVC in children {
            childVC.view.removeFromSuperview()
            childVC.removeFromParent()
        }
    }
}
