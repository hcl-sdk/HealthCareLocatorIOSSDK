//
//  OKHCPLastSearch.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/1/20.
//

import Foundation

struct OKHCPLastSearch: Codable {
    let timeInterval: Double!
    let search: OKHCPSearchData
}

extension OKHCPLastSearch: Equatable {
    static func == (lhs: OKHCPLastSearch, rhs: OKHCPLastSearch) -> Bool {
        return lhs.search == rhs.search
    }
}

struct OKHCPLastHCP: Codable {
    let timeInterval: Double!
    let activity: Activity!
}

extension OKHCPLastHCP: Equatable {
    static func == (lhs: OKHCPLastHCP, rhs: OKHCPLastHCP) -> Bool {
        return lhs.activity.id == rhs.activity.id
    }
}
