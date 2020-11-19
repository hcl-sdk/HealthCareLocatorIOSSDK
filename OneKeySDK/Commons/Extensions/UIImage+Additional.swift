//
//  UIImage+Additional.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/17/20.
//

import Foundation
import UIKit

extension UIImage {
    static func OKImageWith(name: String) -> UIImage? {
        return (UIImage(named: name, in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate))
    }
}
