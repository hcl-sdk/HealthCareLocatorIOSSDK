//
//  OKSearchConfigure.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/25/20.
//

import Foundation

/**
 The API key provide by the provisioning tools to authenticate with server, you need it to be set before using the searching
 - Important: the API key **MUST** be set before using the *Search* features OR it will raise an exception at run time
 */
public let kAPIKeyConfigure = "apiKey"

/**
Speciality of a HCP to search for
 */
public enum Specialities: CaseIterable {
    case RegisteredPracticalNurse
    case FamilyMedicine
    case Neurosurgery
    
    var code: String {
        switch self {
        case .RegisteredPracticalNurse: return "SP.WCA.RN"
        case .FamilyMedicine: return "SP.WCA.3C"
        case .Neurosurgery: return "SP.WCA.37"
        }
    }
}

/**
 The initialize configuration of the HCP/HCO searching`
 - Note:
 This is optional
 */
public struct OKSearchConfigure {
    let favourites: [Specialities]
    
    public init(favourites: [Specialities]) {
        self.favourites = favourites
    }
}
