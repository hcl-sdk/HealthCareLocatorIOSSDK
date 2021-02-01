//
//  Individual.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/14/20.
//

import Foundation

struct IndividualResult: Codable {
    let individuals: [IndividualWorkPlaceDetails]?
}

public struct IndividualWorkPlaceDetails: Codable {
    public struct Activity: Codable {
        public let id: String!
        public let workplace: Workplace?
    }
    
    public let id: String!
    public let title: KeyedString?
    public let firstName: String?
    public let lastName: String!
    public let middleName: String?
    public let mailingName: String?
    public let specialties: [KeyedString]
    public let professionalType: KeyedString?
    public let mainActivity: IndividualWorkPlaceDetails.Activity!
}

extension IndividualWorkPlaceDetails {
    var composedName: String {
        guard let mailingName = mailingName, !mailingName.isEmpty else {
            return String(format: "%@ %@ %@", firstName ?? "", middleName ?? "", lastName)
        }
        return mailingName
    }
}
