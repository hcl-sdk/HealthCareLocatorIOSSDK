//
//  OKHCPSearchData.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/25/20.
//

import Foundation

struct OKHCPSearchData {
    // search by 'criteria' OR 'code'
    let criteria: String!
    let code: Code?

    // search by 'address' OR 'near me'
    let address: String?
    let isNearMeSearch: Bool?
    
    var result: [ActivityResult]! = []
    
    mutating func change(result: [ActivityResult]) {
        self.result = result
    }
}
