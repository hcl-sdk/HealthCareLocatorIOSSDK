//
//  OKHCPSearchWebServices.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation
import Apollo

public class OKHCPSearchWebServices: SearchAPIsProtocol {
    
    private let apiKey: String!
    private let manager: OKServiceManager!
    
    public required init(apiKey: String, manager: OKServiceManager) {
        self.apiKey = apiKey
        self.manager = manager
    }
    
    public func fetchActivityWith(id: String!,
                           locale: String?,
                           userId: String?,
                           completionHandler: @escaping ((Activity?, Error?) -> Void)) {
        let query = ActivityByIdQuery(apiKey: apiKey,
                                      userId: userId,
                                      id: id,
                                      locale: locale)
        manager.apollo.fetch(query: query) { result in
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
    }
    

    public func fetchCodesByLabel(info: GeneralQueryInput,
                           criteria: String!,
                           codeTypes: [String],
                           userId: String?,
                           completionHandler: @escaping (([Code]?, Error?) -> Void)) {
        let query = CodesByLabelQuery(apiKey: apiKey,
                                      first: info.first,
                                      offset: info.offset,
                                      userId: userId,
                                      criteria: criteria,
                                      codeTypes: codeTypes,
                                      locale: info.locale)
        manager.apollo.fetch(query: query) { result in
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
    }
    
    public func fetchIndividualsByNameWith(info: GeneralQueryInput,
                                    county: String?,
                                    criteria: String!,
                                    userId: String?,
                                    completionHandler: @escaping (([IndividualWorkPlaceDetails]?, Error?) -> Void)) {
        let query = IndividualsByNameQuery(apiKey: apiKey,
                                           first: info.first,
                                           offset: info.offset,
                                           userId: userId,
                                           criteria: criteria,
                                           locale: info.locale)
        manager.apollo.fetch(query: query) { result in
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
    }
    
    public func fetchActivitiesWith(info: GeneralQueryInput,
                             specialties: [String]?,
                             location: GeopointQuery?,
                             county: String?,
                             criteria: String?,
                             userId: String?,
                             completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        let query = ActivitiesQuery(apiKey: apiKey,
                                    first: info.first,
                                    offset: info.offset,
                                    userId: userId,
                                    locale: info.locale,
                                    professionalType: nil,
                                    specialties: specialties,
                                    county: county,
                                    criteria: criteria,
                                    location: location)
        manager.apollo.fetch(query: query) { result in
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
    }
}
