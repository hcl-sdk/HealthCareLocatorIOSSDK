//
//  Bundle+Additional.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation

extension Bundle {
    static func internalBundle() -> Bundle {
        // Pick the internal bundle by using a internal class as the anchor
        return Bundle(for: OKHCPSearchNavigationViewController.self)
    }
}
