//
//  OKManager.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/5/20.
//

import Foundation
import UIKit

/**
 The manager class
 - Example:  This show how to use the **OKManager**
 
 ````
    let manager = OKManager.share
    manager.test()
 ````
 - Note:
 This is just an example first look of the sdk
 */
public class OKManager: NSObject, OKSDKConfigure {
    
    static public let shared = OKManager()
    
    private(set) var searchNavigationController: OKHCPSearchNavigationViewController?
    private(set) var apiKey: String?
    private(set) var userId: String?
    private(set) var searchConfigure: OKSearchConfigure?
    private(set) var lang: String!

    /**
     The callback handler of the manager, setup this property and implement *OkManagerDelegate* to listen for the event of search process
     - Note:
        **OKManager** only support one delegate at the same time so the latest object set to this property will cause the previous setup is replaced
     */
    weak public var delegate: OkManagerDelegate?
    
    private override init() {
        self.lang = NSLocale.preferredLanguages.first ?? "en"
    }
}


extension OKManager: OkManagerProtocol {
    /**
     The API key provide by the provisioning tools to authenticate with server, you need it to be set before using the searching
     - Important: the API key **MUST** be set before using the *Search* features OR it will raise an exception at run time
     */
    public func initialize(apiKey: String,
                           configure: OKSearchConfigure? = nil,
                           handler: ((Bool, Error?) -> Void)? = nil) {
        self.apiKey = apiKey
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
     The configuration for HCP/HCO searching
     */
    public func configure(search: OKSearchConfigure) {
        self.searchConfigure = search
    }
    
    /**
     Change displayed language for the SDK
        - Example:
     ````
     OKManager.shared.setLocale(lang: "en")
     ````
     - Note: By default the SDK will use the device language, if the device langue is not in supported range, the language will fallback to English
     */
    public func setLocale(lang: String) {
        self.lang = lang
    }
    
    /**
     The default configuration for HCP/HCO searching will be use if no configure set
     */
    public func getDefaultSearchConfigure() -> OKSearchConfigure {
        return OKSearchConfigure()
    }
    
    /**
     Retrive the instant for the HCP search process
     - Returns: The navigation controller of the search HCP process
     */
    public func getHCPSearchViewController(fullMode: Bool) -> OKHCPSearchNavigationViewController {
        let searchVC = OKHCPSearchNavigationViewController(configure: searchConfigure ?? getDefaultSearchConfigure(),
                                                           fullMode: fullMode)
        searchNavigationController = searchVC
        return searchVC
    }
    
    /**
     Retrive the default theme configuration for the user interface displaying
     - Returns: An object of type *OKThemeConfigure* which can be use to configure for the search component UI
     */
    public func getDefaultUIConfigure() -> OKThemeConfigure {
        return OKThemeConfigure(primaryColor: UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1),
                                secondaryColor: UIColor(red: 227/255, green: 243/255, blue: 223/255, alpha: 1))
    }
    
    @discardableResult
    public func searchNearMe(specialities: [String]) -> Bool {
        if let searchVC = searchNavigationController,
           searchVC.isViewLoaded,
           let resultVC = ViewControllers.viewControllerWith(identity: .searchResult) as? SearchResultViewController {
            resultVC.data = SearchData(criteria: nil,
                                            codes: specialities.map {Code(id: $0, longLbl: nil)},
                                            address: nil,
                                            isNearMeSearch: false,
                                            isQuickNearMeSearch: true)
            searchVC.pushViewController(resultVC, animated: true)
            return true
        } else {
            return false
        }
    }
}
