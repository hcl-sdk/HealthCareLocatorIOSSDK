//
//  SearchResultModel.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation

public struct SearchResult: Encodable, Decodable {
    let data: [SearchResultModel]!
}


public struct SearchResultModel: Encodable, Decodable {
    let category: String!
    let doctor: String!
    let address: String!
    let lat: Double!
    let long: Double!
}
