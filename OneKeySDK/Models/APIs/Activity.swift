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
    let distance: Double?
    let relevance: Int?
    let activity: Activity!
}

struct Activity: Codable {
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
    
    var contactMessage: String {
        return [workplace.name, workplace.address.composedAddress, phone].compactMap {$0}.joined(separator: "\n")
    }
    
    func shareMessageWith(appName: String?, and downloadUrl: String?) -> String {
        if let unwrapAppName = appName {
            if let unwrapUrl = downloadUrl {
                return String(format: "onekey_sdk_share_template_full".localized,
                              individual.composedName,
                              (individual.professionalType?.label ?? ""),
                              individual.specialties.compactMap {$0.label}.joined(separator: ", "),
                              contactMessage,
                              unwrapAppName,
                              unwrapUrl)
            } else {
                return String(format: "onekey_sdk_share_template_without_parent_url".localized,
                              individual.composedName,
                              (individual.professionalType?.label ?? ""),
                              individual.specialties.compactMap {$0.label}.joined(separator: ", "),
                              contactMessage,
                              unwrapAppName)
            }
        } else {
            return String(format: "onekey_sdk_share_template_without_parent_info".localized,
                          individual.composedName,
                          (individual.professionalType?.label ?? ""),
                          individual.specialties.compactMap {$0.label}.joined(separator: ", "),
                          contactMessage)
        }
    }
}

struct Individual: Codable {
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

extension Individual {
    var composedName: String {
        return [firstName, middleName, lastName].compactMap {$0}.joined(separator: " ")
    }
}

struct Workplace: Codable {
    let name: String?
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
    let postalCode: String?
    let location: Geopoint?
}

extension Address {
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

struct Geopoint: Codable {
    let lat: Double!
    let lon: Double!
}
