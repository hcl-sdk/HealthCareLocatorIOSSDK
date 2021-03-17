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
let kModifyActivityURLFormat = "https://www.healthcarelocator.com/%@/suggest-modification?apiKey=%@&id=%@"
let kServerURL = "https://apim-prod-westeu-onekey.azure-api.net/api/graphql/query"

//
let kDefaultZoomLevel: CLLocationDistance = 2000

//
let kDefaultSearchNearMeDistance: Double = 2000 // 2000 meters
let kDefaultSearchAddressDistance: Double = 5000 // 5000 meters
let kDefaultSearchCityDistance: Double = 10000 // 10000 meters

//
var kNearMeTitle: String {
    return "hcl_near_me".localized
}

var kNoAddressTitle: String {
    return "hcl_anywhere".localized
}

let kLocalizedTableName = "HealthCareLocatorSDK"
