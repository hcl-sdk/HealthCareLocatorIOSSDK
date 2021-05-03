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
    let speciality: String?
    let country: String?
    
    /**
     - Params:
        - entry: The first UI will be displyed for the user
        - speciality: The code of specialities will be use to perform the quick search action
        - country: 
     */
    public init(entry: SearchEntry? = nil, speciality: String? = nil, country: String? = nil) {
        self.entry = entry ?? .home
        self.speciality = speciality
        self.country = country
    }
}

class HCLSearchConfigureValidator {
    static func validate(configure: HCLSearchConfigure) -> Bool {
        return (configure.entry == .home && configure.speciality != nil) ? false : true
    }
}
