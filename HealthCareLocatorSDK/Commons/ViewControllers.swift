//
//  ViewControllers.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/25/20.
//

import Foundation
import UIKit

let storyBoardName = "HCPSearch"

class ViewControllers {
    enum Identity: String {
        case home = "SearchHomeViewController"
        case homeFull = "SearchHomeFullViewController"
        case searchResult = "SearchResultViewController"
        case searchResultMap = "SearchResultMapViewController"
        
    }
    
    static func viewControllerWith(identity: Identity) -> UIViewController {
        return UIStoryboard(name: storyBoardName, bundle: Bundle.internalBundle()).instantiateViewController(withIdentifier: identity.rawValue)
    }
}
