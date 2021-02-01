//
//  LastSearch.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/1/20.
//

import Foundation

struct LastSearch: Codable {
    let timeInterval: Double!
    let search: SearchDataCore
}

extension LastSearch: Equatable {
    static func == (lhs: LastSearch, rhs: LastSearch) -> Bool {
        return lhs.search == rhs.search
    }
}
