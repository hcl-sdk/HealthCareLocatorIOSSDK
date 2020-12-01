//
//  OkDatabase.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/1/20.
//

import Foundation

class OKDatabase {
    static func getLastSearchesHistory() -> [OKHCPLastSearch] {
        return MockOKHCPSearchWebServices().getMockLastSearchResult()
    }
}
