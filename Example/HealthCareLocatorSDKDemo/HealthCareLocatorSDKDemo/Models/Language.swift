//
//  Language.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 12/23/20.
//

import Foundation

enum Language: String, CaseIterable {
    case english = "en"
    case french = "fr"

    var title: String {
        switch self {
        case .english:
            return "English"
        case .french:
            return "French"
        }
    }
}
