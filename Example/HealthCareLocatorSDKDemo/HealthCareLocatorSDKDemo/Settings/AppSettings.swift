//
//  AppSettings.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/12/20.
//

import Foundation
import UIKit
import HealthCareLocatorSDK

class AppSettings {
    private enum Key: String {
        case primaryColor
        case secondaryColor
        case APIKey
        case selectedThemeMenu
        case selectedTheme
        case language
        case isSuggestEditHCPEnabled
        case countries
        case specialtyLabel
        case specialtyCode
        case distanceDefault
        case distanceUnit
        case darkMode
        case darkModeForMap
    }
    
    static private func getValueFor(key: String) -> Any? {
        let userDefaults = UserDefaults.standard
        return userDefaults.value(forKey: key)
    }
    
    static private func set(value: Any?, for key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: key)
        userDefaults.synchronize()
    }
    
    static var primaryColor: UIColor? {
        get {
            guard let hexCode = AppSettings.getValueFor(key: Key.primaryColor.rawValue) as? String else {return nil}
            return UIColor(hexString: hexCode)
        }
        
        set {
            let hexCode = newValue?.toHex()
            AppSettings.set(value: hexCode, for: Key.primaryColor.rawValue)
        }
    }
    
    static var secondaryColor: UIColor? {
        get {
            guard let hexCode = AppSettings.getValueFor(key: Key.secondaryColor.rawValue) as? String else {return nil}
            return UIColor(hexString: hexCode)
        }
        
        set {
            let hexCode = newValue?.toHex()
            AppSettings.set(value: hexCode, for: Key.secondaryColor.rawValue)
        }
    }
    
    static var APIKey: String {
        get {
            guard let key = AppSettings.getValueFor(key: Key.APIKey.rawValue) as? String else {return "10000254863a293c"}
            return key.count > 0 ? key : "10000254863a293c"
        }
        
        set {
            AppSettings.set(value: newValue, for: Key.APIKey.rawValue)
        }
    }
    
    static var selectedThemeMenu: String? {
        get {
            guard let menu = AppSettings.getValueFor(key: Key.selectedThemeMenu.rawValue) as? String else {return nil}
            return menu
        }
        
        set {
            AppSettings.set(value: newValue, for: Key.selectedThemeMenu.rawValue)
        }
    }
    
    static var selectedTheme: Theme {
        get {
            if let themeData = AppSettings.getValueFor(key: Key.selectedTheme.rawValue) as? Data {
                do {
                    let theme = try JSONDecoder().decode(Theme.self, from: themeData)
                    return theme
                } catch {
                    return Theme.defaultGreenTheme
                }
            } else {
                return Theme.defaultGreenTheme
            }
        }
        
        set {
            AppSettings.set(value: (try? JSONEncoder().encode(newValue)), for: Key.selectedTheme.rawValue)
        }
    }
    
    static var language: String {
        get {
            guard let lang = (AppSettings.getValueFor(key: Key.language.rawValue) as? String) ?? NSLocale.preferredLanguages.first else {return "en"}
            return lang
        }
        
        set {
            AppSettings.set(value: newValue, for: Key.language.rawValue)
        }
    }
    
    static var isSuggestEditHCPEnabled: Bool {
        get {
            guard let val = AppSettings.getValueFor(key: Key.isSuggestEditHCPEnabled.rawValue) as? String else {return true}
            return val == "true"
        }
        
        set {
            AppSettings.set(value: newValue ? "true" : "false", for: Key.isSuggestEditHCPEnabled.rawValue)
        }
    }
    
    static var countries: String {
        get {
            guard let countries = (AppSettings.getValueFor(key: Key.countries.rawValue) as? String)
            else {
                return ""
            }
            return countries
        }
        
        set {
            AppSettings.set(value: newValue, for: Key.countries.rawValue)
        }
    }
    
    static var specialtyLabel: String {
        get {
            guard let specialtyLabel = (AppSettings.getValueFor(key: Key.specialtyLabel.rawValue) as? String)
            else {
                return ""
            }
            return specialtyLabel
        }
        
        set {
            AppSettings.set(value: newValue, for: Key.specialtyLabel.rawValue)
        }
    }
    
    static var specialtyCode: String {
        get {
            guard let specialtyCode = (AppSettings.getValueFor(key: Key.specialtyCode.rawValue) as? String)
            else {
                return ""
            }
            return specialtyCode
        }
        
        set {
            AppSettings.set(value: newValue, for: Key.specialtyCode.rawValue)
        }
    }
    
    static var distanceDefault: Double? {
        get {
            return (AppSettings.getValueFor(key: Key.distanceDefault.rawValue) as? Double)
        }
        
        set {
            AppSettings.set(value: newValue, for: Key.distanceDefault.rawValue)
        }
    }
    
    static var distanceDefaultText: String? {
        guard let distanceDefault = self.distanceDefault else { return nil }
        return String(format: "%.0f", distanceDefault)
    }
    
    static var distanceUnit: HCLDistanceUnit {
        get {
            guard let distanceUnit = (AppSettings.getValueFor(key: Key.distanceUnit.rawValue) as? String) else { return .km }
            return HCLDistanceUnit(rawValue: distanceUnit) ?? .km
        }
        
        set {
            AppSettings.set(value: newValue.rawValue, for: Key.distanceUnit.rawValue)
        }
    }
    
    static var darkMode: Bool {
        get {
            guard let darkMode = (AppSettings.getValueFor(key: Key.darkMode.rawValue) as? Bool) else { return false }
            return darkMode
        }
        
        set {
            AppSettings.set(value: newValue, for: Key.darkMode.rawValue)
        }
    }
    
    static var darkModeForMap: Bool {
        get {
            guard let darkModeForMap = (AppSettings.getValueFor(key: Key.darkModeForMap.rawValue) as? Bool) else { return false }
            return darkModeForMap
        }
        
        set {
            AppSettings.set(value: newValue, for: Key.darkModeForMap.rawValue)
        }
    }
}
