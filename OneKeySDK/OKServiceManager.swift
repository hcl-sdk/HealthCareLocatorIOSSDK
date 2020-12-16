//
//  OKServiceManager.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/18/20.
//

import UIKit
import Apollo

class OKServiceManager: NSObject {
    var apiKey: String?
    static let shared = OKServiceManager()
    lazy var apollo = ApolloClient(url: URL(string: "https://apim-dev-eastus-onekey.azure-api.net/api/graphql/query")!)
    
    private override init() {}
    
    func initializeClient(apiKey: String) {
        self.apiKey = apiKey
    }
}
