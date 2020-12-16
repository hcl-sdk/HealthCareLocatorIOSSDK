//
//  Individual.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/14/20.
//

import Foundation

struct IndividualResult: Codable {
    let individuals: [IndividualWorkPlaceDetails]?
}

struct IndividualWorkPlaceDetails: Codable {
    struct Activity: Codable {
        let workplace: Workplace?
    }
    
    let id: String!
    let title: String?
    let firstName: String?
    let lastName: String!
    let middleName: String?
    let mailingName: String?
    let specialties: [KeyedString]
    let mainActivity: IndividualWorkPlaceDetails.Activity!
}

extension IndividualWorkPlaceDetails {
    var composedName: String {
        guard let mailingName = mailingName else {
            return String(format: "%@ %@ %@", firstName ?? "", middleName ?? "", lastName)
        }
        return mailingName
    }
}
