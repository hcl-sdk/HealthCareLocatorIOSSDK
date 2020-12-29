//
//  OKSearchConfigure.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/25/20.
//

import Foundation

/**
 The initialize configuration of the HCP/HCO searching`
 - Note:
 This is optional
 */
public struct OKSearchConfigure {
    public enum SearchEntry: CaseIterable {
        case nearMe
        case home
    }
    
    let entry: SearchEntry!
    let favourites: [String]
    
    public init(entry: SearchEntry? = nil, favourites: [String]? = nil) {
        self.entry = entry ?? .home
        self.favourites = favourites ?? []
    }
}

class OKSearchConfigureValidator {
    static func validate(configure: OKSearchConfigure) -> Bool {
        return (configure.entry == .home && configure.favourites.count > 0) ? false : true
    }
}
