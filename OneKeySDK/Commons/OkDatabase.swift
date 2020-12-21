//
//  OkDatabase.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/1/20.
//

import Foundation

class OKDatabase {
    private enum Keys: String {
        case LastSearches
        case LastHCPsConsoulted
    }
    
    static func save(search: OKHCPSearchData) {
        let toSave = OKHCPLastSearch(timeInterval: Date().timeIntervalSince1970, search: search)
        var savedSearches = getLastSearchesHistory()
        if let index = savedSearches.firstIndex(of: toSave) {
            savedSearches.remove(at: index)
        }
        savedSearches.insert(toSave, at: 0)
        setLastSearchesHistory(searches: savedSearches)
    }
    
    static func setLastSearchesHistory(searches: [OKHCPLastSearch]) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(searches.compactMap {try? JSONEncoder().encode($0)}, forKey: Keys.LastSearches.rawValue)
        userDefault.synchronize()
    }
    
    static func getLastSearchesHistory() -> [OKHCPLastSearch] {
        let userDefault = UserDefaults.standard
        if let data = userDefault.array(forKey: Keys.LastSearches.rawValue) as? [Data] {
            return data.compactMap {try? JSONDecoder().decode(OKHCPLastSearch.self, from: $0)}
        } else {
            return []
        }
    }
    
    static func save(activity: Activity) {
        let toSave = OKHCPLastHCP(timeInterval: Date().timeIntervalSince1970, activity: activity)
        var savedActivities = getLastHCPsConsulted()
        if let index = savedActivities.firstIndex(of: toSave) {
            savedActivities.remove(at: index)
        }
        savedActivities.insert(toSave, at: 0)
        setLastHCPsConsulted(HCPs: savedActivities)
    }
    
    static func setLastHCPsConsulted(HCPs: [OKHCPLastHCP]) {
        let userDefault = UserDefaults.standard
        userDefault.setValue(HCPs.compactMap {try? JSONEncoder().encode($0)}, forKey: Keys.LastHCPsConsoulted.rawValue)
        userDefault.synchronize()
    }
    
    static func getLastHCPsConsulted() -> [OKHCPLastHCP] {
        let userDefault = UserDefaults.standard
        if let data = userDefault.array(forKey: Keys.LastHCPsConsoulted.rawValue) as? [Data] {
            return data.compactMap {try? JSONDecoder().decode(OKHCPLastHCP.self, from: $0)}
        } else {
            return []
        }
    }
}
