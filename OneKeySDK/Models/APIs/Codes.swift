//
//  Codes.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/15/20.
//

import Foundation

public struct CodeResult: Codable {
    let codes: [Code]?
}

public struct Code: Codable {
    let id: String!
    let longLbl: String?
}

extension Code: Equatable {
    public static func == (lhs: Code, rhs: Code) -> Bool {
        return lhs.id == rhs.id
    }
}
