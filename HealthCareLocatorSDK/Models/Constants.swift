//
//  Constants.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/25/20.
//

import Foundation
import MapKit

let kSupportedCodeTypes = ["SP"]
let kModifyActivityURLFormat = "https://onekeysdk.ekinoffy.com/%@/suggest-modification?apiKey=%@&id=%@"
let kServerURL = "https://apim-dev-eastus-onekey.azure-api.net/api/graphql/query"

//
let kDefaultZoomLevel: CLLocationDistance = 2000

//
var kNearMeTitle: String {
    return "hcl_near_me".localized
}

let kLocalizedTableName = "HealthCareLocatorSDK"
