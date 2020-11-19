//
//  OKBaseButton.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import UIKit

@IBDesignable
class OKBaseButton: UIButton {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.cornerRadius = cornerRadius
    }
}
