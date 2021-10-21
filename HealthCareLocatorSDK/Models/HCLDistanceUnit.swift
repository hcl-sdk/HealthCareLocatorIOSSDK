//
//  HCLDistanceUnit.swift
//  HealthCareLocatorSDK
//
//  Created by theloi on 11/10/2021.
//

import Foundation

public enum HCLDistanceUnit: String, Codable {
    case km = "Kilometer"
    case mile = "Mile"
    
    var toMeter: Double {
        switch self {
        case .km:
            return 1000
        case .mile:
            return 1609.344
        }
    }
}
