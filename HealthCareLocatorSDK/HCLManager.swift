//
//  HCLManager.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/5/20.
//

import Foundation
import UIKit

/**
 The manager class which control UI customization and access ability of the SDK
 - Example:  This show how to use the **HCLManager**
 
 ````
    let manager = HCLManager.share
    manager.initialize(apiKey: <YOUR_API_KEY>,
                       configure: <SEARCH_CONFIGURATION_BASE_ON_YOUR_BUSINESS>,
                       theme: <FONT_AND_COLOR_CUSTOMIZATION>,
                       icons: <ICONS_CUSTOMIZATION>,
                       handler: <CALLBACK_TO_HANDLE_INITILAZATION_RESULT>)
    let searchHCPVC = manager.getWebServices()
 ````
 - Note:
Except the api key, all of other params is optional so you can simple start a new searching just by providing the api key
 - Important:
 The search view should be access through HCLManager instance, don't try to create *HCLHCPSearchNavigationViewController* your-self
 */
public class HCLManager: NSObject, HCLSDKConfigure {
    
    static public let shared = HCLManager()
    private(set) var apiKey: String?
    private(set) var searchNavigationController: HCLHCPSearchNavigationViewController?
    private(set) var userId: String?
    private(set) var appName: String?
    private(set) var appDownloadLink: String?
    private(set) var searchConfigure: HCLSearchConfigure?
    private(set) var themConfigure: HCLThemeConfigure?
    private(set) var iconsConfigure: HCLIconsConfigure?
    private(set) var lang: HCLLanguage!
    private(set) var isSuggestEditHCPEnable: Bool! = true

    private override init() {
        self.lang = .english
    }
}


extension HCLManager: HCLManagerProtocol {
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
                           configure: HCLSearchConfigure? = nil,
                           theme: HCLThemeConfigure? = nil,
                           icons: HCLIconsConfigure? = nil,
                           handler: ((Bool, Error?) -> Void)? = nil) {
        self.apiKey = apiKey
        HCLServiceManager.shared.initialize(apiKey: apiKey)
        self.themConfigure = theme
        self.iconsConfigure = icons
        if let configure = configure {
            if HCLSearchConfigureValidator.validate(configure: configure) {
                searchConfigure = configure
                handler?(true, nil)
            } else {
                print(HCLError.initializeConfigureValidateFailed)
                handler?(false, HCLError.initializeConfigureValidateFailed)
            }
        } else {
            searchConfigure = getDefaultSearchConfigure()
            handler?(true, nil)
        }
    }
    
    
    public func set(suggestEditHCPEnable: Bool) {
        self.isSuggestEditHCPEnable = suggestEditHCPEnable
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
    public func configure(search: HCLSearchConfigure?) {
        self.searchConfigure = search
    }
    
    func configure(theme: HCLThemeConfigure?) {
        self.themConfigure = theme
    }
    
    func configure(icons: HCLIconsConfigure?) {
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
    public func setLocale(language: HCLLanguage) {
        self.lang = language
    }
    
    /**
     The default configuration for HCP/HCO searching will be used if no configure set
     */
    public func getDefaultSearchConfigure() -> HCLSearchConfigure {
        return HCLSearchConfigure()
    }
    
    /**
     Retrive the root instant for the HCP search screens
     - Returns:
        - HCLHCPSearchNavigationViewController: The navigation controller of the search HCP process
     */
    public func getHCPSearchViewController() -> HCLHCPSearchNavigationViewController {
        let searchVC = HCLHCPSearchNavigationViewController()
        searchVC.configure(search: searchConfigure ?? getDefaultSearchConfigure())
        searchNavigationController = searchVC
        return searchVC
    }
    
    /**
     Retrive the instant for calling the APIs directly without attach default search UI If you want to build your own search UI from scratch
     - Returns:
        - HCLHCPSearchWebServices: The web services instant for calling search APIs
     - Important:
     The initialize need to be finish fist before using the web services.
     - Example:
     ````
     HCLManager.share.initialize(apiKey: <YOUR_API_KEY>,
                        handler: {[unowned manager = HCLManager.share] success in
        if success {
            let webService = manager.getWebServices()
        }
     })
     ````
     */
    public func getWebServices() -> HCLHCPSearchWebServices {
        let webService = HCLHCPSearchWebServices(manager: HCLServiceManager.shared)
        return webService
    }
    
    /**
     Retrive the default theme configuration for the user interface displaying
     - Returns:
        - HCLThemeConfigure: An object  which can be used to configure for the screens displaying
     */
    public func getDefaultUIConfigure() -> HCLThemeConfigure {
        return HCLThemeConfigure()
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
