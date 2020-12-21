//
//  OKSearchHistoryViewModel.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import Foundation
import CoreLocation

enum HistorySection: Equatable {
    static func == (lhs: HistorySection, rhs: HistorySection) -> Bool {
        switch lhs {
        case .nearMe(let lhsTitle, let lhsActivities):
            switch rhs {
            case .lastSearchs, .lasHCPConsolted:
                return false
            case .nearMe:
                return true
            }
        case .lastSearchs(let title, let searches):
            switch rhs {
            case .nearMe, .lasHCPConsolted:
                return false
            case .lastSearchs:
                return true
            }
        case .lasHCPConsolted(let title, let activities):
            switch rhs {
            case .nearMe, .lastSearchs:
                return false
            case .lasHCPConsolted:
                return true
            }
        }
    }
    
    case nearMe(title: String, activities: [ActivityResult])
    case lastSearchs(title: String, searches: [OKHCPLastSearch])
    case lasHCPConsolted(title: String, activities: [OKHCPLastHCP])
    
    var title: String {
        switch self {
        case .nearMe(let title, _):
            return title
        case .lastSearchs(let title, _):
            return title
        case .lasHCPConsolted(let title, _):
            return title
        }
    }
}

class OKSearchHistoryViewModel {
    var webService: OKHCPSearchWebServicesProtocol!
    
    init(webService: OKHCPSearchWebServicesProtocol) {
        self.webService = webService
    }
    
    func fetchHistory(_ completion: @escaping ((Result<[HistorySection], Error>) -> Void)) {
        let mockData = MockOKHCPSearchWebServices().getMockActivities()
        let lastSearches = OKDatabase.getLastSearchesHistory()
        let lastHCPsConsulted = OKDatabase.getLastHCPsConsulted()
        
        let mockResult = [HistorySection.nearMe(title: "HCPs near me", activities: mockData),
                          HistorySection.lastSearchs(title: "Last searches", searches: lastSearches),
                          HistorySection.lasHCPConsolted(title: "Last HCPs consulted", activities: lastHCPsConsulted)]
        completion(.success(mockResult))
    }
}
