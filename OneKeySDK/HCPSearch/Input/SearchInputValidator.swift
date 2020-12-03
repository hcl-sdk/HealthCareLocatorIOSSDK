//
//  SearchInputValidator.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/24/20.
//

import Foundation

class SearchInputValidator {
    
    func isCriteriaValid(criteriaText: String?) -> Bool {
        guard let criteria = criteriaText else {return false}
        return !criteria.isEmpty
    }
    
    func isPlaceAddressValid(placeAddressText: String?) -> Bool {
//        guard let place = placeAddressText else {return false}
//        return !place.isEmpty
        return true
    }
}
