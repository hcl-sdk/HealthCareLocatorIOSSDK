//
//  UIImage+Additional.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/17/20.
//

import Foundation
import UIKit

/**
 Default images used as icons around the SDK's screen.
 - Parameters:
    - name: Name of the icon
 - Returns: The optional image object
 */
public extension UIImage {
    static func OKImageWith(name: String) -> UIImage? {
        return (UIImage(named: name, in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate))
    }
}
