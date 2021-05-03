//
//  AppConfigure.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/1/20.
//

import Foundation

class AppConfigure {
    private enum Keys: String {
        case deviceId
        case LastSearches
        case LastHCPsConsoulted
    }

    static var deviceId: String {
        get {
            if let deviceId = UserDefaults.standard.string(forKey: Keys.deviceId.rawValue) {
                return deviceId
            } else {
                let newDeviceId = UUID().uuidString
                let userDefaults = UserDefaults.standard
                userDefaults.setValue(newDeviceId, forKey: Keys.deviceId.rawValue)
                userDefaults.synchronize()
                return newDeviceId
            }
        }
        set {
            let newDeviceId = newValue
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(newDeviceId, forKey: Keys.deviceId.rawValue)
            userDefaults.synchronize()
        }
    }
    
    static func getVoteFor(activityId: String, by deviceId: String) -> Bool? {
        if let value = UserDefaults.standard.string(forKey: "\(activityId)-\(deviceId)") {
            return value == "true"
        } else {
            return nil
        }
    }
    
    static func setVoteFor(activityId: String, by deviceId: String, with value: Bool){
        let stringVal = value == true ? "true" : "false"
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(stringVal, forKey: "\(activityId)-\(deviceId)")
        userDefaults.synchronize()
    }
    
    static func save(search: SearchData) {
        let toSave = LastSearch(timeInterval: Date().timeIntervalSince1970, search: search.core())
        var savedSearches = getLastSearchesHistory()
        if let index = savedSearches.firstIndex(of: toSave) {
            savedSearches.remove(at: index)
        }
        savedSearches.insert(toSave, at: 0)
        setLastSearchesHistory(searches: savedSearches)
    }
    
    static func removeSearchHistoryAt(index: Int) {
        var searches = getLastSearchesHistory()
        if searches.count > index {
            searches.remove(at: index)
            setLastSearchesHistory(searches: searches)
        }
    }
    
    static func setLastSearchesHistory(searches: [LastSearch]) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(searches.compactMap {try? JSONEncoder().encode($0)}, forKey: Keys.LastSearches.rawValue)
        userDefault.synchronize()
    }
    
    static func getLastSearchesHistory() -> [LastSearch] {
        let userDefault = UserDefaults.standard
        if let data = userDefault.array(forKey: Keys.LastSearches.rawValue) as? [Data] {
            return data.compactMap {try? JSONDecoder().decode(LastSearch.self, from: $0)}
        } else {
            return []
        }
    }
    
    static func save(activity: Activity) {
        let toSave = LastHCPConsulted(timeInterval: Date().timeIntervalSince1970, activity: activity)
        var savedActivities = getLastHCPsConsulted()
        if let index = savedActivities.firstIndex(of: toSave) {
            savedActivities.remove(at: index)
        }
        savedActivities.insert(toSave, at: 0)
        setLastHCPsConsulted(HCPs: savedActivities)
    }
    
    static func removeActivityHistoryAt(index: Int) {
        var activities = getLastHCPsConsulted()
        if activities.count > index {
            activities.remove(at: index)
            setLastHCPsConsulted(HCPs: activities)
        }
    }
    
    static func setLastHCPsConsulted(HCPs: [LastHCPConsulted]) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(HCPs.compactMap {try? JSONEncoder().encode($0)}, forKey: Keys.LastHCPsConsoulted.rawValue)
        userDefault.synchronize()
    }
    
    static func getLastHCPsConsulted() -> [LastHCPConsulted] {
        let userDefault = UserDefaults.standard
        if let data = userDefault.array(forKey: Keys.LastHCPsConsoulted.rawValue) as? [Data] {
            return data.compactMap {try? JSONDecoder().decode(LastHCPConsulted.self, from: $0)}
        } else {
            return []
        }
    }
}
