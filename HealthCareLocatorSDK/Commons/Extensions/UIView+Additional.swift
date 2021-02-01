//
//  UIView+Additional.swift
//  HealthCareLocatorSDK
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
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = path.cgPath
        layer.mask = mask
    }
}
