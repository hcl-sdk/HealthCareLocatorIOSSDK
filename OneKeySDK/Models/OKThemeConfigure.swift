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
    public let title1Font: UIFont!
    public let title2Font: UIFont!
    public let title3Font: UIFont!
    public let searchInputFont: UIFont!
    public let buttonFont: UIFont!
    public let smallFont: UIFont!

    // MARK: Colors
    public let primaryColor: UIColor!
    public let secondaryColor: UIColor!
    public let markerColor: UIColor!
    public let selectedMarkerColor: UIColor!

    public init(defaultFont: UIFont? = UIFont(name: "Helvetica", size: 14.0),
                title1Font: UIFont? = UIFont(name: "Helvetica", size: 20.0),
                title2Font: UIFont? = UIFont(name: "Helvetica", size: 16.0),
                title3Font: UIFont? = UIFont(name: "Helvetica", size: 14.0),
                searchInputFont: UIFont? = UIFont(name: "Helvetica", size: 16.0),
                buttonFont: UIFont? = UIFont(name: "Helvetica", size: 14.0),
                smallFont: UIFont? = UIFont(name: "Helvetica", size: 12.0),
                primaryColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1),
                secondaryColor: UIColor? = UIColor(red: 227/255, green: 243/255, blue: 223/255, alpha: 1),
                markerColor: UIColor? = UIColor(red: 254/255, green: 138/255, blue: 18/255, alpha: 1),
                selectedMarkerColor: UIColor? = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)) {
        // Fonts
        self.defaultFont = defaultFont
        self.title1Font = title1Font
        self.title2Font = title2Font
        self.title3Font = title3Font
        self.searchInputFont = searchInputFont
        self.buttonFont = buttonFont
        self.smallFont = smallFont
        
        // Colors
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.markerColor = markerColor
        self.selectedMarkerColor = selectedMarkerColor
    }
}
