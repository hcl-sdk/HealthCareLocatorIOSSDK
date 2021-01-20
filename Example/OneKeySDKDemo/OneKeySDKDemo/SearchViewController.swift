//
//  SearchViewController.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/11/20.
//

import UIKit
import OneKeySDK

class SearchViewController: UIViewController {
    
    var config: OKSearchConfigure?
    
    @IBOutlet weak var wrapperView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get manager and assign the delegate to listen for search process events
        let shared = OKManager.shared
        let iconsConfig = OKIconsConfigure(searchIcon: UIImage(named: "iconStar")!,
                                           profileIcon: UIImage(named: "iconStar")!,
                                           editIcon: UIImage(named: "iconStar")!,
                                           crossIcon: UIImage(named: "iconStar")!,
                                           backIcon: UIImage(named: "iconStar")!,
                                           geolocIcon: UIImage(named: "iconStar")!,
                                           markerMinIcon: UIImage(named: "iconStar")!,
                                           mapIcon: UIImage(named: "iconStar")!,
                                           listIcon: UIImage(named: "iconStar")!,
                                           sortIcon: UIImage(named: "iconStar")!,
                                           arrowRightIcon: UIImage(named: "iconStar")!,
                                           mapGeolocIcon: UIImage(named: "iconStar")!,
                                           phoneIcon: UIImage(named: "iconStar")!,
                                           faxIcon: UIImage(named: "iconStar")!,
                                           websiteIcon: UIImage(named: "iconStar")!,
                                           voteUpIcon: UIImage(named: "iconStar")!,
                                           voteDownIcon: UIImage(named: "iconStar")!)
        //        shared.configure(search: OKSearchConfigure(favourites: Specialities.allCases.map {$0.code}))
        shared.setLocale(lang: AppSettings.language.rawValue)
        shared.set(appName: "Caretiny", appDownloadLink: "https://www.example.com")
        shared.initialize(apiKey: AppSettings.APIKey ?? "",
                          configure: config,
                          theme: AppSettings.selectedTheme.sdkThemeConfigure) {[weak self] (success, error) in
            if success {
                shared.delegate = self
                self?.initSearchUI()
            } else {
                let alertView = UIAlertController(title: "Error", message: "Unknow error", preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
                alertView.addAction(closeAction)
                self?.present(alertView, animated: true, completion: nil)
            }
        }
    }

    private func initSearchUI() {
        // Get the initial HCP search instants
        let HCPSearchVC = OKManager.shared.getHCPSearchViewController()
        setupSearchView(searchVC: HCPSearchVC)
    }
    
    private func setupSearchView(searchVC: OKHCPSearchNavigationViewController) {
//        searchVC.modalPresentationStyle = .overFullScreen
//        present(searchVC, animated: true, completion: nil)
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
