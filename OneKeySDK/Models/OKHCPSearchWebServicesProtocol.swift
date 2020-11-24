//
//  OKHCPSearchWebServicesProtocol.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation

protocol OKHCPSearchWebServicesProtocol {
    func searchHCPWith(input: SearchHCPInput, manager: OKServiceManager, completionHandler: @escaping (([Activity]?, OKError?) -> Void))
}
