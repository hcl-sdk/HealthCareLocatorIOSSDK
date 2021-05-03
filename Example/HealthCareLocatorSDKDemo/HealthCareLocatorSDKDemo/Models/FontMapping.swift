//
//  FontMapping.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 12/9/20.
//

import Foundation

enum FontStyles: String, CaseIterable {
    case Regular
    case Bold
    case Italic
    case BoldItalic
    
    var title: String {
        switch self {
        case .Regular:
            return "Regular"
        case .Bold:
            return "Bold"
        case .Italic:
            return "Italic"
        case .BoldItalic:
            return "Bold-Italic"
        }
    }
}

enum FontMapping: String, CaseIterable {
    case Arial
    case Helvetica
    case TimesNewRoman
    
    static func from(familyName: String) -> FontMapping? {
        switch familyName {
        case "Arial":
            return .Arial
        case "Helvetica Neue":
            return .Helvetica
        case "Times New Roman":
            return .TimesNewRoman
        default:
            return nil
        }
    }
    
    var fontFamily: String {
        switch self {
        case .Arial:
            return "Arial"
        case .Helvetica:
            return "Helvetica"
        case .TimesNewRoman:
            return "TimesNewRoman"
        }
    }

    var regularFontName: String {
        switch self {
        case .Arial:
            return "ArialMT"
        case .Helvetica:
            return "HelveticaNeue"
        case .TimesNewRoman:
            return "TimesNewRomanPSMT"
        }
    }
    
    var boldFontName: String {
        switch self {
        case .Arial:
            return "Arial-BoldMT"
        case .Helvetica:
            return "HelveticaNeue-Bold"
        case .TimesNewRoman:
            return "TimesNewRomanPS-BoldMT"
        }
    }
    
    var italicFontName: String {
        switch self {
        case .Arial:
            return "Arial-ItalicMT"
        case .Helvetica:
            return "HelveticaNeue-Italic"
        case .TimesNewRoman:
            return "TimesNewRomanPS-ItalicMT"
        }
    }
    
    var boldItalicFontName: String {
        switch self {
        case .Arial:
            return "Arial-BoldItalicMT"
        case .Helvetica:
            return "HelveticaNeue-BoldItalic"
        case .TimesNewRoman:
            return "TimesNewRomanPS-BoldItalicMT"
        }
    }
    
    func getFontNameWith(style: FontStyles) -> String {
        switch style {
        case .Regular:
            return regularFontName
        case .Bold:
            return boldFontName
        case .Italic:
            return italicFontName
        case .BoldItalic:
            return boldItalicFontName
        }
    }
}
