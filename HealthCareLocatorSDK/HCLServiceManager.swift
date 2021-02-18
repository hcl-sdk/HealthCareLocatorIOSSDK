//
//  HCLServiceManager.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/18/20.
//

import UIKit
import Apollo

class HCLServiceManager: NSObject {
    
    static let shared = HCLServiceManager()
    private var apiKey: String?
    
    private var apollo: ApolloClient?
    
    private override init() {}
    
    func initialize(apiKey: String) {
        self.apiKey = apiKey
        self.apollo = initClientWith(apiKey: apiKey)
    }
    
    private func initClientWith(apiKey: String) -> ApolloClient {
        // The cache is necessary to set up the store, which we're going to hand to the provider
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let client = URLSessionClient()
        
        let provider = LegacyInterceptorProvider(client: client, shouldInvalidateClientOnDeinit: true, store: store)
        
        let url = URL(string: kServerURL)!
        
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: url,
                                                                 additionalHeaders: ["Ocp-Apim-Subscription-Key" : apiKey])
        
        
        // Remember to give the store you already created to the client so it
        // doesn't create one on its own
        return ApolloClient(networkTransport: requestChainTransport,
                            store: store)
    }
}

extension HCLServiceManager {
    
    func fetchLabelBy(code: String, completionHandler: @escaping ((Code?, Error?) -> Void)) {
        if let apollo = self.apollo {
            let query = LabelsByCodeQuery(criteria: code, codeTypes: kSupportedCodeTypes)
            apollo.fetch(query: query) { result in
                switch result {
                case .success(let response):
                    if let result = response.data?.labelsByCode?.codes?.first {
                        completionHandler(Code(id: result?.id, longLbl: result?.longLbl), nil)
                    }
                    break
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
        } else {
            completionHandler(nil, HCLError.initializeConfigureValidateFailed)
        }
    }
    
    func fetchActivityWith(id: String!,
                           locale: String?,
                           userId: String?,
                           completionHandler: @escaping ((Activity?, Error?) -> Void)) {
        if let apollo = self.apollo {
            let query = ActivityByIdQuery(userId: userId,
                                          id: id,
                                          locale: locale)
            apollo.fetch(query: query) { result in
                switch result {
                case .success(let response):
                    if let json = response.data?.activityById?.jsonObject,
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed),
                       let result = try? JSONDecoder().decode(Activity.self, from: jsonData) {
                        completionHandler(result, nil)
                    }
                    break
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
        } else {
            completionHandler(nil, HCLError.initializeConfigureValidateFailed)
        }
    }
    
    func fetchCodesByLabel(info: GeneralQueryInput,
                           criteria: String!,
                           codeTypes: [String],
                           userId: String?,
                           completionHandler: @escaping (([Code]?, Error?) -> Void)) {
        if let apollo = self.apollo {
            let query = CodesByLabelQuery(first: info.first,
                                          offset: info.offset,
                                          userId: userId,
                                          criteria: criteria,
                                          codeTypes: codeTypes,
                                          locale: info.locale)
            apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely) { result in
                switch result {
                case .success(let response):
                    if let json = response.data?.codesByLabel?.jsonObject,
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed),
                       let result = try? JSONDecoder().decode(CodeResult.self, from: jsonData) {
                        completionHandler(result.codes, nil)
                    }
                    break
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
        } else {
            completionHandler(nil, HCLError.initializeConfigureValidateFailed)
        }
    }
    
    func fetchIndividualsByNameWith(info: GeneralQueryInput,
                                    county: String?,
                                    criteria: String!,
                                    userId: String?,
                                    completionHandler: @escaping (([IndividualWorkPlaceDetails]?, Error?) -> Void)) {
        if let apollo = self.apollo {
            let query = IndividualsByNameQuery(first: info.first,
                                               offset: info.offset,
                                               userId: userId,
                                               criteria: criteria,
                                               locale: info.locale)
            apollo.fetch(query: query) { result in
                switch result {
                case .success(let response):
                    if let json = response.data?.individualsByName?.jsonObject,
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed),
                       let result = try? JSONDecoder().decode(IndividualResult.self, from: jsonData) {
                        completionHandler(result.individuals, nil)
                    }
                    break
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
        } else {
            completionHandler(nil, HCLError.initializeConfigureValidateFailed)
        }
    }
    
    func fetchActivitiesWith(info: GeneralQueryInput,
                             specialties: [String]?,
                             location: GeopointQuery?,
                             county: String?,
                             criteria: String?,
                             userId: String?,
                             completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        if let apollo = self.apollo {
            let query = ActivitiesQuery(first: info.first,
                                        offset: info.offset,
                                        userId: userId,
                                        locale: info.locale,
                                        professionalType: nil,
                                        specialties: specialties,
                                        county: county,
                                        criteria: criteria,
                                        location: location)
            apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely) { result in
                switch result {
                case .success(let response):
                    if let json = response.data?.jsonObject,
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed),
                       let result = try? JSONDecoder().decode(ActivityResponse.self, from: jsonData) {
                        completionHandler(result.activities, nil)
                    }
                    break
                case .failure(let error):
                    completionHandler(nil, error)
                }
            }
        } else {
            completionHandler(nil, HCLError.initializeConfigureValidateFailed)
        }
    }
}
