//
//  MockOKHCPSearchWebServices.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation
import Apollo

class MockOKHCPSearchWebServices: OKHCPSearchWebServicesProtocol {
    func fetchActivityWith(apiKey: String,
                           userId: String?,
                           id: String!,
                           locale: String?,
                           manager: OKServiceManager,
                           completionHandler: @escaping ((Activity?, Error?) -> Void)) {
        completionHandler(getMockActivityDetail()!, nil)
    }
    
    func fetchCodesByLabel(info: GeneralQueryInput,
                           criteria: String!,
                           codeTypes: [String],
                           manager: OKServiceManager,
                           completionHandler: @escaping (([Code]?, Error?) -> Void)) {
        completionHandler(getMockCodes(), nil)
    }
    
    func fetchIndividualsByNameWith(info: GeneralQueryInput,
                                    county: String?,
                                    criteria: String!,
                                    manager: OKServiceManager,
                                    completionHandler: @escaping (([IndividualWorkPlaceDetails]?, Error?) -> Void)) {
        completionHandler(getMockIndividuals(), nil)
    }
    
    func fetchActivitiesWith(info: GeneralQueryInput,
                             specialties: [String]?,
                             location: GeopointQuery?,
                             county: String?,
                             criteria: String!,
                             manager: OKServiceManager,
                             completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        completionHandler(getMockActivities(), nil)
    }
}

// MARK: Mock data
extension MockOKHCPSearchWebServices {
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
    
    func getMockLastSearchResult() -> [OKHCPLastSearch] {
        return [OKHCPLastSearch(criteria: "General Practitioner", address: "75008, Paris", timeInterval: 1606798423, selected: nil),
                OKHCPLastSearch(criteria: "Cardiologist", address: "75008, Paris", timeInterval: 1606778423, selected: nil),
                OKHCPLastSearch(criteria: "Dr Hababou Danielle", address: "38 Rue Beaujon, 75008 Paris", timeInterval: 1606698423, selected: getMockActivities().last),
                OKHCPLastSearch(criteria: "Dr Hababou Danielle", address: "38 Rue Beaujon, 75008 Paris", timeInterval: 1606598423, selected: getMockActivities().first)]
    }
}
