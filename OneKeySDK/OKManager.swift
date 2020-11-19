//
//  OKManager.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/5/20.
//

import Foundation
import UIKit
import Apollo

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
public class OKManager: NSObject {
    static public let shared = OKManager()
    lazy var apollo = ApolloClient(url: URL(string: "https://dev-eastus-onekey-sdk-apim.azure-api.net/api/graphql")!)

    /**
     The callback handler of the manager, setup this property and implement *OkManagerDelegate* to listen for the event of search process
     - Note:
        **OKManager** only support one delegate at the same time so the latest object set to this property will cause the previous setup is replaced
     */
    weak public var delegate: OkManagerDelegate?
    
    private override init() {}
}


extension OKManager: OkManagerProtocol {    
    /**
     Retrive the instant for the HCP search process
     - Returns: The navigation controller of the search HCP process
     */
    public func getHCPSearchViewController() -> OKHCPSearchNavigationViewController {
        guard let searchVC = UIStoryboard(name: "HCPSearch",
                                          bundle: Bundle.internalBundle()).instantiateViewController(withIdentifier: "OKHCPSearchViewController") as? OKHCPSearchNavigationViewController else {
            fatalError("Unable to load search screen")
        }
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
}
