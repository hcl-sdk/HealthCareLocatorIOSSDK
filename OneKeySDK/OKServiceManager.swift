//
//  OKServiceManager.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/18/20.
//

import UIKit
import Apollo

public class OKServiceManager: NSObject {

    static let shared = OKServiceManager()
    private var apiKey: String?
    
    lazy var apollo: ApolloClient = {
        // The cache is necessary to set up the store, which we're going to hand to the provider
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let client = URLSessionClient()

        let provider = LegacyInterceptorProvider(client: client, shouldInvalidateClientOnDeinit: true, store: store)
        
        let url = URL(string: "https://apim-dev-eastus-onekey.azure-api.net/api/graphql/query")!

        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: url,
                                                                 additionalHeaders: ["Ocp-Apim-Subscription-Key" : apiKey.orEmpty])
                                                                 

        // Remember to give the store you already created to the client so it
        // doesn't create one on its own
        return ApolloClient(networkTransport: requestChainTransport,
                            store: store)
    }()
    
    private override init() {}

    func initialize(apiKey: String) {
        self.apiKey = apiKey
    }
}
