//
//  OKThemeConfigure.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation
import UIKit

public struct OKThemeConfigure {
    // MARK: Fonts
    public let defaultFont: UIFont!
    public let titleFont: UIFont!
    
    // MARK: Colors
    public let primaryColor: UIColor!
    public let secondaryColor: UIColor!
    public let markerColor: UIColor!
    public let selectedMarkerColor: UIColor!

    public init(defaultFont: UIFont? = UIFont.systemFont(ofSize: 14.0),
                titleFont: UIFont? = UIFont.systemFont(ofSize: 20.0),
                primaryColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1),
                secondaryColor: UIColor? = UIColor(red: 227/255, green: 243/255, blue: 223/255, alpha: 1),
                markerColor: UIColor? = UIColor(red: 254/255, green: 138/255, blue: 18/255, alpha: 1),
                selectedMarkerColor: UIColor? = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)) {
        self.defaultFont = defaultFont
        self.titleFont = titleFont
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.markerColor = markerColor
        self.selectedMarkerColor = selectedMarkerColor
    }
}
