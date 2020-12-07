//
//  AppSettings.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/12/20.
//

import Foundation
import UIKit

class AppSettings {
    private enum Key: String {
        case primaryColor
        case secondaryColor
        case APIKey
        case selectedThemeMenu
        case selectedTheme
        case fullHomeModeEnabled
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
    
    static var APIKey: String? {
        get {
            guard let key = AppSettings.getValueFor(key: Key.APIKey.rawValue) as? String else {return nil}
            return key
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
    
    static var fullHomeModeEnabled: Bool {
        get {
            guard let isOn = AppSettings.getValueFor(key: Key.fullHomeModeEnabled.rawValue) as? String else {return false}
            return isOn == "true"
        }
        
        set {
            AppSettings.set(value: newValue ? "true" : "false", for: Key.fullHomeModeEnabled.rawValue)
        }
    }
}
