//
//  SearchData.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/25/20.
//

import Foundation

struct SearchData: Codable {
    // search by 'criteria' OR 'code'
    let criteria: String!
    let codes: [Code]?

    // search by 'address' OR 'near me'
    let address: String?
    let isNearMeSearch: Bool?
    
    // search access from Home OR Input
    let isQuickNearMeSearch: Bool?
    
    var result: [ActivityResult]! = []
    
    mutating func change(result: [ActivityResult]) {
        self.result = result
    }
}

extension SearchData: Equatable {
    static func == (lhs: SearchData, rhs: SearchData) -> Bool {
        return lhs.criteria == lhs.criteria &&
            lhs.codes == rhs.codes &&
            lhs.address == lhs.address &&
            lhs.isNearMeSearch == rhs.isNearMeSearch &&
            lhs.isQuickNearMeSearch == rhs.isQuickNearMeSearch
    }
}
