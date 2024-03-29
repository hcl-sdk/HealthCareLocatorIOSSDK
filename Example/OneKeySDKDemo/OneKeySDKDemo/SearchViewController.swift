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
        shared.delegate = self
        // Get the initial HCP search instants
        let HCPSearchVC = OKManager.shared.getHCPSearchViewController()
        let theme = OKThemeConfigure(primaryColor: UIColor.red,
                                     secondaryColor: UIColor.lightGray,
                                     HCPThemeConfigure: OKHCPSearchConfigure(titleText: "From Ekino with love",
                                                                             HCPSearch: OKIconTitleConfigure(image: UIImage(systemName: "magnifyingglass"),
                                                                                                                                     titleText: "Find and Locate other HCP",
                                                                                                                                     descriptionText: "Lorem ipsum dolor sit amet, consect adipiscing elit"),
                                                                             consultSearch: OKIconTitleConfigure(image: UIImage(systemName: "person"),
                                                                                                                 titleText: "Consult Profile",
                                                                                                                 descriptionText: "Lorem ipsum dolor sit amet, consect adipiscing elit"),
                                                                             informationUpdate: OKIconTitleConfigure(image: UIImage(systemName: "pencil"),
                                                                                                                     titleText: "Request my Information update",
                                                                                                                     descriptionText: "Lorem ipsum dolor sit amet, consect adipiscing elit")))
        HCPSearchVC.theme = theme//shared.getDefaultUIConfigure()
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
