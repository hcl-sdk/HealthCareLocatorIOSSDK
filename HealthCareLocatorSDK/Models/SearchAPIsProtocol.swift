//
//  SearchAPIsProtocol.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation

protocol SearchAPIsProtocol {
    
    init(manager: HCLServiceManager)
    
    func fetchLabelBy(code: String,
                      completionHandler: @escaping ((Code?, Error?) -> Void))
    
    func fetchCodesByLabel(info: GeneralQueryInput,
                           criteria: String!,
                           codeTypes: [String],
                           userId: String?,
                           completionHandler: @escaping (([Code]?, Error?) -> Void))
    
    func fetchIndividualsByNameWith(info: GeneralQueryInput,
                                    county: String?,
                                    criteria: String!,
                                    userId: String?,
                                    completionHandler: @escaping (([IndividualWorkPlaceDetails]?, Error?) -> Void))
    
    func fetchActivitiesWith(info: GeneralQueryInput,
                             specialties: [String]?,
                             location: GeopointQuery?,
                             county: String?,
                             criteria: String?,
                             userId: String?,
                             completionHandler: @escaping (([ActivityResult]?, Error?) -> Void))
    
    func fetchActivityWith(id: String!,
                           locale: String?,
                           userId: String?,
                           completionHandler: @escaping ((Activity?, Error?) -> Void))
}
