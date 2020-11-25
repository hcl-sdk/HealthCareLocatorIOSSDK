//
//  OKHCPSearchWebServices.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation
import Apollo

class OKHCPSearchWebServices: OKHCPSearchWebServicesProtocol {
    func searchHCPWith(input: OKHCPSearchInput, manager: OKServiceManager, completionHandler: @escaping (([Activity]?, OKError?) -> Void)) {
        let query = ActivitiesQuery(apiKey: "1", criteria: "Hello")
        manager.apollo.fetch(query: query) { result in
            switch result {
            case .success(let queryResult):
                completionHandler(queryResult.data?.activities?.compactMap {$0?.activity}, nil)
            case .failure(let error):
                print(error)
                completionHandler(nil, .queryActivitiesFailed)
            }
        }
    }
}
