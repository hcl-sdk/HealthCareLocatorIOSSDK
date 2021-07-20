//
//  Language.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 12/23/20.
//

import Foundation

enum Language: String, CaseIterable {
    case us = "en"
    case uk = "en_GB"
    case french = "fr_FR"
    case canada = "fr_CA"
    case arabic = "ar_SA"
    case dutch = "nl_NL"
    case russian = "ru_RU"
    case turkish = "tr_TR"
    case polish = "pl_PL"
    case portuguese = "pt_PT"
    case german = "de_DE"
    case italian = "it_IT"
    case spanish = "es_ES"
    case spanish_co = "es_CO"

    var title: String {
        switch self {
        case .us:
            return "US"
        case .french:
            return "French"
        case .canada:
            return "Canada"
        case .spanish:
            return "Spanish"
        case .spanish_co:
            return "Spanish(CO)"
        case .italian:
            return "Italian"
        case .german:
            return "German"
        case .portuguese:
            return "Portuguese"
        case .polish:
            return "Polish"
        case .turkish:
            return "Turkish"
        case .russian:
            return "Russian"
        case .arabic:
            return "Arabic"
        case .dutch:
            return "Dutch"
        case .uk:
            return "UK"
        }
    }
}
