//
//  HCLSearchConfigure.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/25/20.
//

import Foundation

/**
 The initialize configuration of the HCP/HCO searching
 */
public struct HCLSearchConfigure {
    /**
     The first UI will be displyed for the user
     - Params:
        - nearMe: Quick access to the search result screen
        - home: Default search home screen
     */
    public enum SearchEntry: CaseIterable {
        case nearMe
        case home
    }
    
    let entry: SearchEntry!
    let favourites: [String]
    
    /**
     - Params:
        - entry: The first UI will be displyed for the user
        - favourites: The list of specialities will be use to perform the quick search action
     */
    public init(entry: SearchEntry? = nil, favourites: [String]? = nil) {
        self.entry = entry ?? .home
        self.favourites = favourites ?? []
    }
}

class HCLSearchConfigureValidator {
    static func validate(configure: HCLSearchConfigure) -> Bool {
        return (configure.entry == .home && configure.favourites.count > 0) ? false : true
    }
}
