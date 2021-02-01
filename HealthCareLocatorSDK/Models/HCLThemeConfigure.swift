//
//  HCLThemeConfigure.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation
import UIKit

/**
 The theme configuration object which can be used to customize user interface for the screen of the seaching process
````
 let theme = HCLThemeConfigure(defaultFont: UIFont(name: "HelveticaNeue", size: 14.0),
                              titleMainFont: UIFont(name: "HelveticaNeue", size: 20.0),
                              titleSecondaryFont: UIFont(name: "HelveticaNeue-Medium", size: 16.0),
                              searchResultTotalFont: UIFont(name: "HelveticaNeue-Medium", size: 14.0),
                              searchResultTitleFont: UIFont(name: "HelveticaNeue", size: 16.0),...
 let manager = HCLManager.shared
 manager.initialize(apiKey: <YOUR_API_KEY>, theme: theme)
 ````
 - Note:
 All of the properties of the theme configuration are optional, if the values is not set then a default value will be load to the UI
 - Important:
 Assign the them configuration while init the **HCLManager** and before adding search screens into your app, If the theme configuration is not provided during initilization of **HCLManager**, a default theme will be loaded into the UI
 
 Reference to the
 
 [document]: https://appnucleus.dvnet.com/onekey-sdk-help/index.htm#t=About_customizing_pre-built_search_screens.htm%23Home_screen_full_size_&rhsearch=ios&rhsyns=%20  "Theme configuration"
 
 to get more detail how the theme value will be used
 */
public struct HCLThemeConfigure {

    // MARK: Fonts
    public let defaultFont: UIFont!
    public let titleMainFont: UIFont!
    public let titleSecondaryFont: UIFont!
    public let searchResultTotalFont: UIFont!
    public let searchResultTitleFont: UIFont!
    public let resultTitleFont: UIFont!
    public let resultSubTitleFont: UIFont!
    public let profileTitleFont: UIFont!
    public let profileSubTitleFont: UIFont!
    public let profileTitleSectionFont: UIFont!
    public let cardTitleFont: UIFont!
    public let modalTitleFont: UIFont!
    public let searchInputFont: UIFont!
    public let sortCriteriaFont: UIFont!
    public let buttonFont: UIFont!
    public let smallFont: UIFont!
    public let noResultTitleFont: UIFont!
    public let noResultDescFont: UIFont!

    // MARK: Colors
    public let primaryColor: UIColor!
    public let secondaryColor: UIColor!
    public let buttonBkgColor: UIColor!
    public let buttonAcceptBkgColor: UIColor!
    public let buttonDiscardBkgColor: UIColor!
    public let buttonBorderColor: UIColor!
    public let cardBorderColor: UIColor!
    public let markerColor: UIColor!
    public let markerSelectedColor: UIColor!
    public let viewBkgColor: UIColor!
    public let listBkgColor: UIColor!
    public let voteUpColor: UIColor!
    public let voteDownColor: UIColor!
    public let darkColor: UIColor!
    public let greyColor: UIColor!
    public let greyDarkColor: UIColor!
    public let greyDarkerColor: UIColor!
    public let greyLightColor: UIColor!
    public let greyLighterColor: UIColor!

    public init(defaultFont: UIFont? = UIFont(name: "HelveticaNeue", size: 14.0),
                titleMainFont: UIFont? = UIFont(name: "HelveticaNeue", size: 20.0),
                titleSecondaryFont: UIFont? = UIFont(name: "HelveticaNeue-Medium", size: 16.0),
                searchResultTotalFont: UIFont? = UIFont(name: "HelveticaNeue-Medium", size: 14.0),
                searchResultTitleFont: UIFont? = UIFont(name: "HelveticaNeue", size: 16.0),
                resultTitleFont: UIFont? = UIFont(name: "HelveticaNeue", size: 14.0),
                resultSubTitleFont: UIFont? = UIFont(name: "HelveticaNeue", size: 14.0),
                profileTitleFont: UIFont? = UIFont(name: "HelveticaNeue", size: 18.0),
                profileSubTitleFont: UIFont? = UIFont(name: "HelveticaNeue", size: 16.0),
                profileTitleSectionFont: UIFont? = UIFont(name: "HelveticaNeue", size: 16.0),
                cardTitleFont: UIFont? = UIFont(name: "HelveticaNeue-Medium", size: 16.0),
                modalTitleFont: UIFont? = UIFont(name: "HelveticaNeue", size: 18.0),
                searchInputFont: UIFont? = UIFont(name: "HelveticaNeue", size: 16.0),
                sortCriteriaFont: UIFont? = UIFont(name: "HelveticaNeue", size: 16.0),
                buttonFont: UIFont? = UIFont(name: "HelveticaNeue", size: 14.0),
                smallFont: UIFont? = UIFont(name: "HelveticaNeue", size: 12.0),
                noResultTitleFont: UIFont? = UIFont(name: "HelveticaNeue", size: 20.0),
                noResultDescFont: UIFont? = UIFont(name: "HelveticaNeue", size: 16.0),
                primaryColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1),
                secondaryColor: UIColor? = UIColor(red: 0/255, green: 163/255, blue: 224/255, alpha: 1),
                buttonBkgColor: UIColor? = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1),
                buttonAcceptBkgColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1),
                buttonDiscardBkgColor: UIColor? = UIColor(red: 154/255, green: 160/255, blue: 167/255, alpha: 1),
                buttonBorderColor: UIColor? = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1),
                cardBorderColor: UIColor? = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1),
                markerColor: UIColor? = UIColor(red: 254/255, green: 138/255, blue: 18/255, alpha: 1),
                markerSelectedColor: UIColor? = UIColor(red: 253/255, green: 134/255, blue: 112/255, alpha: 1),
                viewBkgColor: UIColor? = UIColor(red: 248/255, green: 249/255, blue: 250/255, alpha: 1),
                listBkgColor: UIColor? = UIColor(red: 248/255, green: 249/255, blue: 250/255, alpha: 1),
                voteUpColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1),
                voteDownColor: UIColor? = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1),
                darkColor: UIColor? = UIColor(red: 43/255, green: 60/255, blue: 77/255, alpha: 1),
                greyColor: UIColor? = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1),
                greyDarkColor: UIColor? = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1),
                greyDarkerColor: UIColor? = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1),
                greyLightColor: UIColor? = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1),
                greyLighterColor: UIColor? = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)) {
        // Fonts
        self.defaultFont = defaultFont
        self.titleMainFont = titleMainFont
        self.titleSecondaryFont = titleSecondaryFont
        self.searchResultTotalFont = searchResultTotalFont
        self.searchResultTitleFont = searchResultTitleFont
        self.resultTitleFont = resultTitleFont
        self.resultSubTitleFont = resultSubTitleFont
        self.profileTitleFont = profileTitleFont
        self.profileSubTitleFont = profileSubTitleFont
        self.profileTitleSectionFont = profileTitleSectionFont
        self.cardTitleFont = cardTitleFont
        self.modalTitleFont = modalTitleFont
        self.searchInputFont = searchInputFont
        self.sortCriteriaFont = sortCriteriaFont
        self.buttonFont = buttonFont
        self.smallFont = smallFont
        self.noResultTitleFont = noResultTitleFont
        self.noResultDescFont = noResultDescFont
        
        // Colors
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.buttonBkgColor = buttonBkgColor
        self.buttonAcceptBkgColor = buttonAcceptBkgColor
        self.buttonDiscardBkgColor = buttonDiscardBkgColor
        self.buttonBorderColor = buttonBorderColor
        self.cardBorderColor = cardBorderColor
        self.markerColor = markerColor
        self.markerSelectedColor = markerSelectedColor
        self.viewBkgColor = viewBkgColor
        self.listBkgColor = listBkgColor
        self.voteUpColor = voteUpColor
        self.voteDownColor = voteDownColor
        self.darkColor = darkColor
        self.greyColor = greyColor
        self.greyDarkColor = greyDarkColor
        self.greyDarkerColor = greyDarkerColor
        self.greyLightColor = greyLightColor
        self.greyLighterColor = greyLighterColor
    }
}

extension HCLThemeConfigure: Equatable {
    public static func == (lhs: HCLThemeConfigure, rhs: HCLThemeConfigure) -> Bool {
        return lhs.defaultFont == rhs.defaultFont &&
            lhs.defaultFont == rhs.defaultFont &&
            lhs.titleMainFont == rhs.titleMainFont &&
            lhs.titleSecondaryFont == rhs.titleSecondaryFont &&
            lhs.searchResultTotalFont == rhs.searchResultTotalFont &&
            lhs.searchResultTitleFont == rhs.searchResultTitleFont &&
            lhs.resultTitleFont == rhs.resultTitleFont &&
            lhs.resultSubTitleFont == rhs.resultSubTitleFont &&
            lhs.profileTitleFont == rhs.profileTitleFont &&
            lhs.profileSubTitleFont == rhs.profileSubTitleFont &&
            lhs.profileTitleSectionFont == rhs.profileTitleSectionFont &&
            lhs.cardTitleFont == rhs.cardTitleFont &&
            lhs.modalTitleFont == rhs.modalTitleFont &&
            lhs.searchInputFont == rhs.searchInputFont &&
            lhs.sortCriteriaFont == rhs.sortCriteriaFont &&
            lhs.buttonFont == rhs.buttonFont &&
            lhs.smallFont == rhs.smallFont &&
            lhs.primaryColor == rhs.primaryColor &&
            lhs.secondaryColor == rhs.secondaryColor &&
            lhs.buttonBkgColor == rhs.buttonBkgColor &&
            lhs.buttonAcceptBkgColor == rhs.buttonAcceptBkgColor &&
            lhs.buttonDiscardBkgColor == rhs.buttonDiscardBkgColor &&
            lhs.buttonBorderColor == rhs.buttonBorderColor &&
            lhs.cardBorderColor == rhs.cardBorderColor &&
            lhs.markerColor == rhs.markerColor &&
            lhs.markerSelectedColor == rhs.markerSelectedColor &&
            lhs.viewBkgColor == rhs.viewBkgColor &&
            lhs.listBkgColor == rhs.listBkgColor &&
            lhs.voteUpColor == rhs.voteUpColor &&
            lhs.voteDownColor == rhs.voteDownColor &&
            lhs.darkColor == rhs.darkColor &&
            lhs.greyColor == rhs.greyColor &&
            lhs.greyDarkColor == rhs.greyDarkColor &&
            lhs.greyDarkerColor == rhs.greyDarkerColor &&
            lhs.greyLightColor == rhs.greyLightColor &&
            lhs.greyLighterColor == rhs.greyLighterColor
    }
}
