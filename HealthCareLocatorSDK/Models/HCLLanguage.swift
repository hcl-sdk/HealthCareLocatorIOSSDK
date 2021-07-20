//
//  HCLLanguage.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 2/5/21.
//

import Foundation

public enum HCLLanguage: String, CaseIterable {
    
    case us = "en"
    case uk
    case french = "fr"
    case canada
    case arabic = "ar"
    case dutch = "nl"
    case russian = "ru"
    case turkish = "tr"
    case polish = "pl"
    case portuguese = "pt"
    case german = "de"
    case italian = "it"
    case spanish = "es"
    case spanish_co

    var code: String {
        switch self {
        case .us:
            return "en"
        case .uk:
            return "en"
        case .french:
            return "fr"
        case .canada:
            return "fr"
        case .arabic:
            return "ar"
        case .dutch:
            return "nl"
        case .russian:
            return "ru"
        case .turkish:
            return "tr"
        case .polish:
            return "pl"
        case .portuguese:
            return "pt"
        case .german:
            return "de"
        case .italian:
            return "it"
        case .spanish:
            return "es"
        case .spanish_co:
            return "es"
        }
    }
    
    var apiCode: String {
        switch self {
        case .us:
            return "en"
        case .uk:
            return "en_GB"
        case .french:
            return "fr_FR"
        case .canada:
            return "fr_CA"
        case .arabic:
            return "ar_SA"
        case .dutch:
            return "nl_NL"
        case .russian:
            return "ru_RU"
        case .turkish:
            return "tr_TR"
        case .polish:
            return "pl_PL"
        case .portuguese:
            return "pt_PT"
        case .german:
            return "de_DE"
        case .italian:
            return "it_IT"
        case .spanish:
            return "es_ES"
        case .spanish_co:
            return "es_CO"
        }
    }
}
