//
//  Language.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 12/23/20.
//

import Foundation

enum Language: String, CaseIterable {
    
    case german = "de"
    case us = "en"
    case spanish = "es-ES"
    case spanish_co = "es-CO"
    case french = "fr"
    case canada = "en-FR"
    case italian = "it"
    case dutch = "nl"
    case polish = "pl"
    case portuguese = "pt"
    case turkish = "tr"
    case russian = "ru"
    case arabic = "ar"

    var title: String {
        switch self {
        case .us:
            return "English"
        case .french:
            return "Français"
        case .canada:
            return "Français (CA)"
        case .spanish:
            return "Español"
        case .spanish_co:
            return "Español (CO)"
        case .italian:
            return "Italiano"
        case .german:
            return "Deutsch"
        case .portuguese:
            return "Português (PT)"
        case .polish:
            return "Polski"
        case .turkish:
            return "Türkçe"
        case .russian:
            return "Pусский"
        case .arabic:
            return "العربیة"
        case .dutch:
            return "Nederlands"
        }
    }
}
