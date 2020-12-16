//
//  Activity.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 12/14/20.
//

import Foundation

struct ActivityResponse: Codable {
    let activities: [ActivityResult]?
}

struct ActivityResult: Codable {
    let distance: Int!
    let activity: Activity!
}

struct Activity: Codable {
    let id: String!
    let individual: Individual!
    let workplace: Workplace!
}

struct Individual: Codable {
    let id: String!
    let title: String?
    let firstName: String?
    let lastName: String!
    let middleName: String?
    let mailingName: String?
    let specialties: [KeyedString]
}

extension Individual {
    var composedName: String {
        guard let mailingName = mailingName else {
            return String(format: "%@ %@ %@", firstName ?? "", middleName ?? "", lastName)
        }
        return mailingName
    }
}

struct Workplace: Codable {
    let address: Address!
}

struct KeyedString: Codable {
    let code: String!
    let label: String!
}

struct Address: Codable {
    let longLabel: String!
    let buildingLabel: String!
    let county: KeyedString?
    let city: KeyedString!
    let country: String!
    let location: Geopoint?
}

extension Address {
    var composedAddress: String {
        var addComponents = [String]()
        addComponents.append(longLabel)
        if let city = city {
            addComponents.append(city.label)
        }
        
//        if let county = county {
//            addComponents.append(county.label)
//        }
//        addComponents.append(country)
        return addComponents.joined(separator: ", ")
    }
}

struct Geopoint: Codable {
    let lat: Double!
    let lon: Double!
}
