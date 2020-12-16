//
//  GeneralQueryInput.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/15/20.
//

import Foundation

struct GeneralQueryInput {
    let apiKey: String!
    let first: Int?
    let offset: Int?
    let userId: String?
    let locale: String?
    let criteria: String?
    
    init(apiKey: String, first: Int? = 10, offset: Int? = 0, userId: String? = nil, locale: String? = "en", criteria: String? = nil) {
        self.apiKey = apiKey
        self.first = first
        self.offset = offset
        self.userId = userId
        self.locale = locale
        self.criteria = criteria
    }
}
