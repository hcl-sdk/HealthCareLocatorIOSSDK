//
//  OKHCPSearchWebServices.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation
import Apollo

class OKHCPSearchWebServices: OKHCPSearchWebServicesProtocol {
    func fetchActivityWith(apiKey: String,
                           userId: String?,
                           id: String!,
                           locale: String?,
                           manager: OKServiceManager,
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
    

    func fetchCodesByLabel(info: GeneralQueryInput,
                           criteria: String!,
                           codeTypes: [String],
                           manager: OKServiceManager,
                           completionHandler: @escaping (([Code]?, Error?) -> Void)) {
        let query = CodesByLabelQuery(apiKey: info.apiKey,
                                      first: info.first,
                                      offset: info.offset,
                                      userId: info.userId,
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
    
    func fetchIndividualsByNameWith(info: GeneralQueryInput,
                                    county: String?,
                                    criteria: String!,
                                    manager: OKServiceManager,
                                    completionHandler: @escaping (([IndividualWorkPlaceDetails]?, Error?) -> Void)) {
        let query = IndividualsByNameQuery(apiKey: info.apiKey,
                                           first: info.first,
                                           offset: info.offset,
                                           userId: info.userId,
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
    
    func fetchActivitiesWith(info: GeneralQueryInput,
                             specialties: [String]?,
                             location: GeopointQuery?,
                             county: String?,
                             criteria: String!,
                             manager: OKServiceManager,
                             completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        let query = ActivitiesQuery(apiKey: info.apiKey,
                                    first: info.first,
                                    offset: info.offset,
                                    userId: info.userId,
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
