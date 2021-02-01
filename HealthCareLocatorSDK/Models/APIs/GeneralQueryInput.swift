//
//  GeneralQueryInput.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/15/20.
//

import Foundation

public struct GeneralQueryInput {
    let first: Int?
    let offset: Int?
    let locale: String?
    let criteria: String?
    
    init(first: Int? = 10, offset: Int? = 0, locale: String? = "en", criteria: String? = nil) {
        self.first = first
        self.offset = offset
        self.locale = locale
        self.criteria = criteria
    }
}
