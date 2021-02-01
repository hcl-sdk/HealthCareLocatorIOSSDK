//
//  HCLError.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation

enum HCLError: LocalizedError {
    case initializeConfigureValidateFailed
    case queryActivitiesFailed
    case locationAccessDenined
    case noResult
}
