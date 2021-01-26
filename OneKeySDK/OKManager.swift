//
//  OKManager.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/5/20.
//

import Foundation
import UIKit

/**
 The manager class which control UI customization and access ability of the SDK
 - Example:  This show how to use the **OKManager**
 
 ````
    let manager = OKManager.share
    manager.initialize(apiKey: <YOUR_API_KEY>,
                       configure: <SEARCH_CONFIGURATION_BASE_ON_YOUR_BUSINESS>,
                       theme: <FONT_AND_COLOR_CUSTOMIZATION>,
                       icons: <ICONS_CUSTOMIZATION>,
                       handler: <CALLBACK_TO_HANDLE_INITILAZATION_RESULT>)
    let searchHCPVC = manager.getHCPSearchViewController()
    present(searchHCPVC, animated: true)
 ````
 - Note:
Except the api key, all of other params is optional so you can simple start a new searching just by providing the api key
 - Important:
 The search view should be access through OKManager instance, don't try to create *OKHCPSearchNavigationViewController* your-self
 */
public class OKManager: NSObject, OKSDKConfigure {
    
    static public let shared = OKManager()
    
    private(set) var searchNavigationController: OKHCPSearchNavigationViewController?
    private(set) var userId: String?
    private(set) var appName: String?
    private(set) var appDownloadLink: String?
    private(set) var searchConfigure: OKSearchConfigure?
    private(set) var themConfigure: OKThemeConfigure?
    private(set) var iconsConfigure: OKIconsConfigure?
    private(set) var lang: String!
    
    private override init() {
        self.lang = NSLocale.preferredLanguages.first ?? "en"
    }
}


extension OKManager: OkManagerProtocol {
    /**
     Initialize for the SDK,  you need it to be set before using the searching
     - Parameters:
        - apiKey: The API key provide by the provisioning tools to authenticate with server
        - configure: Search configure
        - theme: Theme configure
        - icons: Icons configure
        - handler: Handler configure
     - Important: the API key **MUST** be set before using the *Search* features OR it will raise an exception at run time
     */
    public func initialize(apiKey: String,
                           configure: OKSearchConfigure? = nil,
                           theme: OKThemeConfigure? = nil,
                           icons: OKIconsConfigure? = nil,
                           handler: ((Bool, Error?) -> Void)? = nil) {
        OKServiceManager.shared.initialize(apiKey: apiKey)
        self.themConfigure = theme
        self.iconsConfigure = icons
        if let configure = configure {
            if OKSearchConfigureValidator.validate(configure: configure) {
                searchConfigure = configure
                handler?(true, nil)
            } else {
                print(OKError.initializeConfigureValidateFailed)
                handler?(false, OKError.initializeConfigureValidateFailed)
            }
        } else {
            searchConfigure = getDefaultSearchConfigure()
            handler?(true, nil)
        }
    }
    
    /**
     User id should be a uniqueue string to store your user's search history.
     - Parameters:
        - userId: A uniqueue string, depend on your app bussiness rule, this is the key to distinst between users
     */
    public func set(userId: String) {
        self.userId = userId
    }
    
    /**
     Parent app name and download link to be configured
     - Parameters:
        - appName: the app name which interact this SDK, the app name could be display somewhere while user using search feature
        - appDownloadLink: The URL to download the parent app which contains this SDK
     */
    public func set(appName: String, appDownloadLink: String?) {
        self.appName = appName
        self.appDownloadLink = appDownloadLink
    }
    
    /**
     The configuration for HCP/HCO searching
     - Parameters:
        - search:Customize searching by provide your own values
     */
    public func configure(search: OKSearchConfigure?) {
        self.searchConfigure = search
    }
    
    func configure(theme: OKThemeConfigure?) {
        self.themConfigure = theme
    }
    
    func configure(icons: OKIconsConfigure?) {
        self.iconsConfigure = icons
    }
    
    /**
     Change displayed language for the SDK
     - Parameters:
        - lang: Language code
     - Note: By default the SDK will use the device language, if the device langue is not in supported range, the language will fallback to English
     - Important:
    The language code should be one of the supported language: en, fr_CA
     */
    public func setLocale(lang: String) {
        self.lang = lang
    }
    
    /**
     The default configuration for HCP/HCO searching will be used if no configure set
     */
    public func getDefaultSearchConfigure() -> OKSearchConfigure {
        return OKSearchConfigure()
    }
    
    /**
     Retrive the root instant for the HCP search screens
     - Returns:
        - OKHCPSearchNavigationViewController: The navigation controller of the search HCP process
     */
    public func getHCPSearchViewController() -> OKHCPSearchNavigationViewController {
        let searchVC = OKHCPSearchNavigationViewController()
        searchVC.configure(search: searchConfigure ?? getDefaultSearchConfigure())
        searchNavigationController = searchVC
        return searchVC
    }
    
    /**
     Retrive the default theme configuration for the user interface displaying
     - Returns:
        - OKThemeConfigure: An object  which can be used to configure for the screens displaying
     */
    public func getDefaultUIConfigure() -> OKThemeConfigure {
        return OKThemeConfigure()
    }
    
    /**
     Start a new search quickly after attaching the search navigation into your app's UI
     - Example:
    Depend on your business, sometimes you may want to display a searching quickly from you own UI component like menus or buttons...
     - Parameters:
        - specialities: The list of specialities which you want to search for
     - Returns: a boolen value to indicate the action is success or not
     - Note: The result may be failed of you're not attach the root search navigation to your screen yet.
     */
    @discardableResult
    public func searchNearMe(specialities: [String]) -> Bool {
        if let searchVC = searchNavigationController,
           searchVC.isViewLoaded,
           let resultVC = ViewControllers.viewControllerWith(identity: .searchResult) as? SearchResultViewController {
            resultVC.data = SearchData(criteria: nil,
                                       codes: specialities.map {Code(id: $0, longLbl: nil)},
                                       mode: .quickNearMeSearch)
            searchVC.pushViewController(resultVC, animated: true)
            return true
        } else {
            return false
        }
    }
}
