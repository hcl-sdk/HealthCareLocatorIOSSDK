//
//  MockOKHCPSearchWebServices.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation

class MockOKHCPSearchWebServices: OKHCPSearchWebServicesProtocol {
    func searchHCPWith(input: SearchHCPInput, completionHandler: @escaping (([SearchResultModel]?, OKError?) -> Void)) {
        completionHandler(getMockSearchResult(), nil)
    }
    
    private func getMockSearchResult() -> [SearchResultModel] {
        if let path = Bundle.internalBundle().path(forResource: "mock-data", ofType: "json") {
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let result = try? JSONDecoder().decode(SearchResult.self, from: jsonData)
                return result?.data ?? []
             }
        }
        return []
    }
}
