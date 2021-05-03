//
//  HCLHCPSearchWebServices.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation
import Apollo

/**
 The APIs class which used to perform request to the server and retrieve the result without UI required in case you want to build your own search UI
 - Example:  This show how to use the **HCLManager**
 
 ````
    let manager = HCLManager.share
    manager.initialize(apiKey: <YOUR_API_KEY>)
    let webservices = manager.getHCPSearchViewController()
 ````
 - Important:
 The APIs must be access through HCLManager instance after initialize with the api key
 */
public class HCLHCPSearchWebServices: SearchAPIsProtocol {
    
    private let manager: HCLServiceManager!
    
    required init(manager: HCLServiceManager) {
        self.manager = manager
    }
    
    /**
     Fetch detail information of an activity
     */
    public func fetchActivityWith(id: String!,
                           locale: String?,
                           userId: String?,
                           completionHandler: @escaping ((Activity?, Error?) -> Void)) {
        manager.fetchActivityWith(id: id, locale: locale, userId: userId, completionHandler: completionHandler)
    }
    

    /**
     Fetch the list of specialties which can be used to perform activities searching
     */
    public func fetchCodesByLabel(info: GeneralQueryInput,
                           criteria: String!,
                           codeTypes: [String],
                           userId: String?,
                           completionHandler: @escaping (([Code]?, Error?) -> Void)) {
        manager.fetchCodesByLabel(info: info, criteria: criteria, codeTypes: codeTypes, userId: userId, completionHandler: completionHandler)
    }
    
    /**
     Fetch detail info for a code to get its name
     */
    public func fetchLabelBy(code: String, completionHandler: @escaping ((Code?, Error?) -> Void)) {
        manager.fetchLabelBy(code: code, completionHandler: completionHandler)
    }
    
    /**
     Fetch the list of simple individual objects
     - Note: This API does not return the full detail of individual but it light enough to perform quick suggestion on list
     */
    public func fetchIndividualsByNameWith(info: GeneralQueryInput,
                                    county: String?,
                                    criteria: String!,
                                    userId: String?,
                                    completionHandler: @escaping (([IndividualWorkPlaceDetails]?, Error?) -> Void)) {
        manager.fetchIndividualsByNameWith(info: info, county: county, criteria: criteria, userId: userId, completionHandler: completionHandler)
    }
    
    /**
     Fetch the list of activities by using specialties codes or criteria text which input by user
     - Note: specialties codes  or criteria text can only provide one to make the request works as expected
     */
    public func fetchActivitiesWith(info: GeneralQueryInput,
                             specialties: [String]?,
                             location: GeopointQuery?,
                             county: String?,
                             criteria: String?,
                             userId: String?,
                             completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        manager.fetchActivitiesWith(info: info, specialties: specialties, location: location, county: county, criteria: criteria, userId: userId, completionHandler: completionHandler)
    }
}
