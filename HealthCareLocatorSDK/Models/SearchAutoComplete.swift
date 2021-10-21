//
//  SearchAutoComplete.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/15/20.
//

import Foundation
import MapKit

enum SearchAutoComplete {
    case none
    case NearMe
    case Code(code: Code)
    case Individual(individual: IndividualWorkPlaceDetails)
    case Address(address: MKLocalSearchCompletion)
    
    var type: String {
        switch self {
        case .none:
            return "none"
        case .NearMe:
            return "near_me"
        case .Individual(individual: _):
            return "individual"
        case .Address(address: _):
            return "address"
        case .Code(code: _):
            return "code"
        }
    }
    
    var value: String {
        switch self {
        case .none:
            return ""
        case .NearMe:
            return ""
        case .Individual(individual: let individual):
            return individual.composedName
        case .Address(address: let address):
            return "\(address.title), \(address.subtitle)"
        case .Code(code: let code):
            return code.longLbl ?? ""
        }
    }
    
    func getCodeType() -> Code? {
        switch self {
        case .Code(code: let code):
            return code
        default:
            return nil
        }
    }
}
