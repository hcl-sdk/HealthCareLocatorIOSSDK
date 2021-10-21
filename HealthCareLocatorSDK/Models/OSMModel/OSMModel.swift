//
//  OSMModel.swift
//  HealthCareLocatorSDK
//
//  Created by tanphat on 03/08/2021.
//

import Foundation

struct OSMModel: Decodable {

    var display_name: String?
    var name: String?
    var boundingbox: [String]?
}
