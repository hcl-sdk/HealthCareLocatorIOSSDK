//
//  MockHCLHCPSearchWebServices.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation
import Apollo

class MockHCLHCPSearchWebServices: SearchAPIsProtocol {
    
    required init(manager: HCLServiceManager) {
        
    }
    
    func fetchLabelBy(code: String, completionHandler: @escaping ((Code?, Error?) -> Void)) {
        
    }
    
    func fetchActivityWith(id: String!,
                           locale: String?,
                           userId: String?,
                           completionHandler: @escaping ((Activity?, Error?) -> Void)) {
        completionHandler(getMockActivityDetail()!, nil)
    }
    
    func fetchCodesByLabel(info: GeneralQueryInput,
                           criteria: String!,
                           codeTypes: [String],
                           userId: String?,
                           completionHandler: @escaping (([Code]?, Error?) -> Void)) {
        completionHandler(getMockCodes(), nil)
    }
    
    func fetchIndividualsByNameWith(info: GeneralQueryInput,
                                    county: String?,
                                    criteria: String!,
                                    userId: String?,
                                    completionHandler: @escaping (([IndividualWorkPlaceDetails]?, Error?) -> Void)) {
        completionHandler(getMockIndividuals(), nil)
    }
    
    func fetchActivitiesWith(info: GeneralQueryInput,
                             specialties: [String]?,
                             location: GeopointQuery?,
                             county: String?,
                             criteria: String?,
                             userId: String?,
                             completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        completionHandler(getMockActivities(), nil)
    }
}

// MARK: Mock data
extension MockHCLHCPSearchWebServices {
    func getMockActivityDetail() -> Activity? {
        if let path = Bundle.internalBundle().path(forResource: "Mock-Activity-Detail", ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let response = try? JSONDecoder().decode(Activity.self, from: jsonData) {
            return response
        } else {
            return nil
        }
    }
    
    func getMockCodes() -> [Code] {
        if let path = Bundle.internalBundle().path(forResource: "Mock-Codes", ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let response = try? JSONDecoder().decode(CodeResult.self, from: jsonData) {
            return response.codes ?? []
        } else {
            return []
        }
    }
    
    func getMockIndividuals() -> [IndividualWorkPlaceDetails] {
        if let path = Bundle.internalBundle().path(forResource: "Mock-Individuals", ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let response = try? JSONDecoder().decode(IndividualResult.self, from: jsonData) {
            return response.individuals ?? []
        } else {
            return []
        }
    }
    
    func getMockActivities() -> [ActivityResult] {
        if let path = Bundle.internalBundle().path(forResource: "Mock-Activities", ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let response = try? JSONDecoder().decode(ActivityResponse.self, from: jsonData) {
            return response.activities ?? []
        } else {
            return []
        }
    }
}
