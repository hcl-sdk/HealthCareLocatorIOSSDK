//
//  Activity.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 12/14/20.
//

import Foundation

struct ActivityResponse: Codable {
    let activities: [ActivityResult]?
}

public struct ActivityResult: Codable {
    let distance: Double?
    let relevance: Int?
    let activity: Activity!
}

public struct Activity: Codable {
    public let id: String!
    public let phone: String?
    public let fax: String?
    public let webAddress: String?
    public let individual: Individual!
    public let workplace: Workplace!
    
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
                return String(format: "hcl_share_template_full".localized,
                              individual.composedName,
                              (individual.professionalType?.label ?? ""),
                              individual.specialties.compactMap {$0.label}.joined(separator: ", "),
                              contactMessage,
                              unwrapAppName,
                              unwrapUrl)
            } else {
                return String(format: "hcl_share_template_without_parent_url".localized,
                              individual.composedName,
                              (individual.professionalType?.label ?? ""),
                              individual.specialties.compactMap {$0.label}.joined(separator: ", "),
                              contactMessage,
                              unwrapAppName)
            }
        } else {
            return String(format: "hcl_share_template_without_parent_info".localized,
                          individual.composedName,
                          (individual.professionalType?.label ?? ""),
                          individual.specialties.compactMap {$0.label}.joined(separator: ", "),
                          contactMessage)
        }
    }
}

public struct Individual: Codable {
    public struct Activity: Codable {
        public let id: String!
        public let workplace: Workplace!
    }
    
    public let id: String!
    public let firstName: String?
    public let lastName: String!
    public let middleName: String?
    public let mailingName: String?
    public let professionalType: KeyedString?
    public let specialties: [KeyedString]
    public let mainActivity: Individual.Activity!
    public let otherActivities: [Individual.Activity]!
}

extension Individual {
    var composedName: String {
        return [firstName, middleName, lastName].compactMap {$0}.joined(separator: " ")
    }
}

public struct Workplace: Codable {
    public let name: String?
    public let address: Address!
}

public struct KeyedString: Codable {
    public let code: String!
    public let label: String!
}

public struct Address: Codable {
    public let longLabel: String!
    public let buildingLabel: String!
    public let county: KeyedString?
    public let city: KeyedString!
    public let country: String!
    public let postalCode: String?
    public let location: Geopoint?
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

public struct Geopoint: Codable {
    public let lat: Double!
    public let lon: Double!
}
