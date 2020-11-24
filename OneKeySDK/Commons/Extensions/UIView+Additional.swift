//
//  UIView+Additional.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/24/20.
//

import Foundation
import UIKit

extension UIView {
    func setBorderWith(width: CGFloat, cornerRadius: CGFloat, borderColor: UIColor) {
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
    }
}
