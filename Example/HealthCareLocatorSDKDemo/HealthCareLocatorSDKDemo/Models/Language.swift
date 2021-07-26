//
//  Language.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 12/23/20.
//

import Foundation

enum Language: String, CaseIterable {
    case us = "en"
    case uk = "en-GB"
    case french = "fr"
    case canada = "en-FR"
    case arabic = "ar"
    case dutch = "nl"
    case russian = "ru"
    case turkish = "tr"
    case polish = "pl"
    case portuguese = "pt"
    case german = "de"
    case italian = "it"
    case spanish = "es-ES"
    case spanish_co = "es-CO"

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
