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
    public let buttonBackgroundColor: UIColor!
    public let buttonAcceptBackgroundColor: UIColor!
    public let buttonDiscardBackgroundColor: UIColor!
    public let buttonBorderColor: UIColor!
    public let cardBorderColor: UIColor!
    public let markerColor: UIColor!
    public let selectedMarkerColor: UIColor!
    public let viewBackgroundColor: UIColor!
    public let listBackgroundColor: UIColor!
    public let voteUpColor: UIColor!
    public let voteDownColor: UIColor!
    public let darkColor: UIColor!
    public let greyColor: UIColor!
    public let greyDarkColor: UIColor!
    public let greyLightColor: UIColor!
    public let greyLighterColor: UIColor!

    public init(defaultFont: UIFont? = UIFont(name: "Helvetica", size: 14.0),
                title1Font: UIFont? = UIFont(name: "Helvetica", size: 20.0),
                title2Font: UIFont? = UIFont(name: "Helvetica", size: 16.0),
                title3Font: UIFont? = UIFont(name: "Helvetica", size: 14.0),
                searchInputFont: UIFont? = UIFont(name: "Helvetica", size: 16.0),
                buttonFont: UIFont? = UIFont(name: "Helvetica", size: 14.0),
                smallFont: UIFont? = UIFont(name: "Helvetica", size: 12.0),
                primaryColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1),
                secondaryColor: UIColor? = UIColor(red: 0/255, green: 163/255, blue: 224/255, alpha: 1),
                buttonBackgroundColor: UIColor? = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1),
                buttonAcceptBackgroundColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1),
                buttonDiscardBackgroundColor: UIColor? = UIColor(red: 154/255, green: 160/255, blue: 167/255, alpha: 1),
                buttonBorderColor: UIColor? = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1),
                cardBorderColor: UIColor? = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1),
                markerColor: UIColor? = UIColor(red: 254/255, green: 138/255, blue: 18/255, alpha: 1),
                selectedMarkerColor: UIColor? = UIColor(red: 253/255, green: 134/255, blue: 112/255, alpha: 1),
                viewBackgroundColor: UIColor? = UIColor(red: 248/255, green: 249/255, blue: 250/255, alpha: 1),
                listBackgroundColor: UIColor? = UIColor(red: 248/255, green: 249/255, blue: 250/255, alpha: 1),
                voteUpColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1),
                voteDownColor: UIColor? = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1),
                darkColor: UIColor? = UIColor(red: 43/255, green: 60/255, blue: 77/255, alpha: 1),
                greyColor: UIColor? = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1),
                greyDarkColor: UIColor? = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1),
                greyLightColor: UIColor? = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1),
                greyLighterColor: UIColor? = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)) {
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
        self.buttonBackgroundColor = buttonBackgroundColor
        self.buttonAcceptBackgroundColor = buttonAcceptBackgroundColor
        self.buttonDiscardBackgroundColor = buttonDiscardBackgroundColor
        self.buttonBorderColor = buttonBorderColor
        self.cardBorderColor = cardBorderColor
        self.markerColor = markerColor
        self.selectedMarkerColor = selectedMarkerColor
        self.viewBackgroundColor = viewBackgroundColor
        self.listBackgroundColor = listBackgroundColor
        self.voteUpColor = voteUpColor
        self.voteDownColor = voteDownColor
        self.darkColor = darkColor
        self.greyColor = greyColor
        self.greyDarkColor = greyDarkColor
        self.greyLightColor = greyLightColor
        self.greyLighterColor = greyLighterColor

    }
}
