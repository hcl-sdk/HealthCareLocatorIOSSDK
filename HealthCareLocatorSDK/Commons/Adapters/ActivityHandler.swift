//
//  ActivityHandler.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/26/20.
//

import Foundation

protocol ActivityHandler: class {
    func didSelect(activity: ActivityResult)
}
