//
//  Activity.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 12/14/20.
//

import Foundation

public struct ActivityResponse: Codable {
    let activities: [ActivityResult]?
}

public struct ActivityResult: Codable {
    let distance: Double?
    let relevance: Int?
    let activity: Activity!
}

public struct Activity: Codable {
    let id: String!
    let phone: String?
    let fax: String?
    let webAddress: String?
    let individual: Individual!
    let workplace: Workplace!
    
    var allActivities: [Individual.Activity] {
        var allActivities: [Individual.Activity] = [individual.mainActivity]
        allActivities.append(contentsOf: individual.otherActivities)
        return allActivities
    }
}

public struct Individual: Codable {
    struct Activity: Codable {
        let id: String!
        let workplace: Workplace!
    }
    
    let id: String!
    let firstName: String?
    let lastName: String!
    let middleName: String?
    let mailingName: String?
    let professionalType: KeyedString?
    let specialties: [KeyedString]
    let mainActivity: Individual.Activity!
    let otherActivities: [Individual.Activity]!
}

public extension Individual {
    var composedName: String {
        return [firstName, middleName, lastName].compactMap {$0}.joined(separator: " ")
    }
}

public struct Workplace: Codable {
    let name: String?
    let address: Address!
}

public struct KeyedString: Codable {
    let code: String!
    let label: String!
}

public struct Address: Codable {
    let longLabel: String!
    let buildingLabel: String!
    let county: KeyedString?
    let city: KeyedString!
    let country: String!
    let postalCode: String?
    let location: Geopoint?
}

public extension Address {
    var composedAddress: String {
        var addComponents = [String]()
        if !longLabel.isEmpty {
            addComponents.append(longLabel)
        }
        
        if let city = city {
            addComponents.append(city.label)
        }
        return addComponents.joined(separator: ", ")
    }
}

public struct Geopoint: Codable {
    let lat: Double!
    let lon: Double!
}
