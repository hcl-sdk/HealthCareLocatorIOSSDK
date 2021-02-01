//
//  Codes.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/15/20.
//

import Foundation

struct CodeResult: Codable {
    let codes: [Code]?
}

public struct Code: Codable {
    public let id: String!
    public let longLbl: String?
}

extension Code: Equatable {
    public static func == (lhs: Code, rhs: Code) -> Bool {
        return lhs.id == rhs.id
    }
}
