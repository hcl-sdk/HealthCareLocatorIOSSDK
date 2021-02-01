//
//  SearchAutoComplete.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/15/20.
//

import Foundation
import MapKit

enum SearchAutoComplete {
    case NearMe
    case Code(code: Code)
    case Individual(individual: IndividualWorkPlaceDetails)
    case Address(address: MKLocalSearchCompletion)
}
