//
//  Constants.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/25/20.
//

import Foundation
import MapKit

let kSupportedCodeTypes = ["SP"]
// TODO, use environment variables instead of hardcoded values.
let kModifyActivityURLFormat = "https://www-dev.healthcarelocator.com/%@/suggest-modification?apiKey=%@&id=%@"
let kServerURL = "https://api.healthcarelocator.com/api/graphql/query"
let kOSMBaseURL = "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=%@&lon=%@"

//
let kDefaultZoomLevel: CLLocationDistance = 2000

//
var kDefaultDistanceUnit: HCLDistanceUnit = .km
var kDefaultSearchNearMeDistance: Double? = nil
let EARTH_RADIUS_IN_METERS = 6371007.177356707

//
var kNearMeTitle: String {
    return "hcl_near_me".localized
}

var kNoAddressTitle: String {
    return "hcl_anywhere".localized
}

let kLocalizedTableName = "HealthCareLocatorSDK"

//
var kDarkColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
var kDarkLightColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
