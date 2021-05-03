//
//  HCLLanguage.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 2/5/21.
//

import Foundation

public enum HCLLanguage: String, CaseIterable {
    case english = "en"
    case french = "fr"

    var code: String {
        switch self {
        case .english:
            return "en"
        case .french:
            return "fr"
        }
    }
    
    var apiCode: String {
        switch self {
        case .english:
            return "en"
        case .french:
            return "fr_CA"
        }
    }
}
