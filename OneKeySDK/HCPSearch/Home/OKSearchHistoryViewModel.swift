//
//  OKSearchHistoryViewModel.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import Foundation

enum HistorySection {
    case nearMe(title: String, activities: [Activity])
    case lastSearchs(title: String, activities: [Activity])
    case lasHCPConsolted(title: String, activities: [Activity])
    
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
    func fetchHistory(_ completion: @escaping ((Result<[HistorySection], Error>) -> Void)) {
        let mockData = MockOKHCPSearchWebServices().getMockSearchResult()
        let mockResult = [HistorySection.nearMe(title: "HCP near me", activities: mockData),
                          HistorySection.lastSearchs(title: "Last searches", activities: mockData),
                          HistorySection.lasHCPConsolted(title: "Last HCP consulted", activities: mockData)]
        completion(.success(mockResult))
    }
}
