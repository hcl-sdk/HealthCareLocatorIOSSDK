//
//  OKHCPSearchWebServicesProtocol.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation

protocol OKHCPSearchWebServicesProtocol {
    
    func fetchCodesByLabel(info: GeneralQueryInput,
                           criteria: String!,
                           codeTypes: [String],
                           manager: OKServiceManager,
                           completionHandler: @escaping (([Code]?, Error?) -> Void))
    
    func fetchIndividualsByNameWith(info: GeneralQueryInput,
                                    county: String?,
                                    criteria: String!,
                                    manager: OKServiceManager,
                                    completionHandler: @escaping (([IndividualWorkPlaceDetails]?, Error?) -> Void))
    
    func fetchActivitiesWith(info: GeneralQueryInput,
                             specialties: [String]?,
                             location: GeopointQuery?,
                             county: String?,
                             criteria: String?,
                             manager: OKServiceManager,
                             completionHandler: @escaping (([ActivityResult]?, Error?) -> Void))
    
    func fetchActivityWith(apiKey: String,
                           userId: String?,
                           id: String!,
                           locale: String?,
                           manager: OKServiceManager,
                           completionHandler: @escaping ((Activity?, Error?) -> Void))
}
