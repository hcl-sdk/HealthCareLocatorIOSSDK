//
//  Codes.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/15/20.
//

import Foundation

struct CodeResult: Codable {
    let codes: [Code]?
}

struct Code: Codable {
    let id: String!
    let longLbl: String!
}
