//
//  OKBaseButton.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/11/20.
//

import UIKit

@IBDesignable
class BaseButton: UIButton {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
