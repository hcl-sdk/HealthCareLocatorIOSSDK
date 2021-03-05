//
//  SearchData.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/25/20.
//

import Foundation

struct SearchDataCore: Codable, Equatable {
    // search by 'criteria' OR 'code'
    let criteria: String!
    let codes: [Code]?
    let address: String?
    let isNearMeSearch: Bool?
    let isQuickNearMeSearch: Bool?
    
    static func == (lhs: SearchDataCore, rhs: SearchDataCore) -> Bool {
        return lhs.criteria == lhs.criteria &&
            lhs.codes == rhs.codes &&
            lhs.address == lhs.address &&
            lhs.isNearMeSearch == lhs.isNearMeSearch &&
            lhs.isQuickNearMeSearch == lhs.isQuickNearMeSearch
    }
}

struct SearchData {
    enum Mode {
        case baseSearch(country: String?)
        case addressSearch(address: String)
        case nearMeSearch
        case quickNearMeSearch
    }
    
    // search by 'criteria' OR 'code'
    let criteria: String!
    let codes: [Code]?
    
    // search mode: basic search with address, basic near me seach or quick near me search
    let mode: SearchData.Mode!
    
    var isNearMeSearch: Bool {
        return mode == .nearMeSearch || mode == .quickNearMeSearch
    }
    
    func core() -> SearchDataCore {
        switch mode {
        case .addressSearch(let address):
            return SearchDataCore(criteria: criteria,
                                  codes: codes,
                                  address: address,
                                  isNearMeSearch: false,
                                  isQuickNearMeSearch: false)
        case .quickNearMeSearch:
            return SearchDataCore(criteria: criteria,
                                  codes: codes,
                                  address: nil,
                                  isNearMeSearch: false,
                                  isQuickNearMeSearch: true)
        default:
            return SearchDataCore(criteria: criteria,
                                  codes: codes,
                                  address: nil,
                                  isNearMeSearch: true,
                                  isQuickNearMeSearch: false)
        }
    }
    
    static func from(core: SearchDataCore) -> SearchData {
        var mode: Mode!
        if core.isQuickNearMeSearch == true {
            mode = SearchData.Mode.quickNearMeSearch
        } else if core.isNearMeSearch == true {
            mode = SearchData.Mode.nearMeSearch
        } else {
            mode = SearchData.Mode.addressSearch(address: core.address.orEmpty)
        }
        return SearchData(criteria: core.criteria,
                          codes: core.codes,
                          mode: mode)
    }
}

extension SearchData: Equatable {
    static func == (lhs: SearchData, rhs: SearchData) -> Bool {
        return lhs.criteria == lhs.criteria &&
            lhs.codes == rhs.codes &&
            lhs.mode == lhs.mode
    }
}

extension SearchData.Mode: Equatable  {
    static func == (lhs: SearchData.Mode, rhs: SearchData.Mode) -> Bool {
        switch lhs {
        case .baseSearch:
            switch rhs {
            case .baseSearch:
                return true
            default:
                return false
            }
        case .addressSearch(let addressLhs):
            switch rhs {
            case .addressSearch(let addressRhs):
                return addressLhs == addressRhs
            default:
                return false
            }
        case .nearMeSearch:
            switch rhs {
            case .nearMeSearch:
                return true
            default:
                return false
            }
        case .quickNearMeSearch:
            switch rhs {
            case .quickNearMeSearch:
                return true
            default:
                return false
            }
        }
    }
}
