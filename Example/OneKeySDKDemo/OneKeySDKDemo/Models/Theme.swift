//
//  Theme.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/13/20.
//

import Foundation
import UIKit

struct Theme: Encodable, Decodable, Equatable {
    static let defaultSystemFontName = "HelveticaNeue"
    static let defaultSystemBoldFontName = "HelveticaNeue-Bold"
    
    // Fonts
    var defaultFont: FontInfo!
    var titleMainFont: FontInfo!
    var titleSecondaryFont: FontInfo!
    var searchResultTotalFont: FontInfo!
    var searchResultTitleFont: FontInfo!
    var resultTitleFont: FontInfo!
    var resultSubTitleFont: FontInfo!
    var profileTitleFont: FontInfo!
    var profileSubTitleFont: FontInfo!
    var profileTitleSectionFont: FontInfo!
    var cardTitleFont: FontInfo!
    var modalTitleFont: FontInfo!
    var searchInputFont: FontInfo!
    var sortCriteriaFont: FontInfo!
    var buttonFont: FontInfo!
    var smallFont: FontInfo!
    
    // Colors
    var primaryColor: String!
    var secondaryColor: String!
    var buttonBkgColor: String!
    var buttonAcceptBkgColor: String!
    var buttonDiscardBkgColor: String!
    var buttonBorderColor: String!
    var cardBorderColor: String!
    var markerColor: String!
    var markerSelectedColor: String!
    var viewBkgColor: String!
    var listBkgColor: String!
    var voteUpColor: String!
    var voteDownColor: String!
    var darkColor: String!
    var greyColor: String!
    var greyDarkColor: String!
    var greyDarkerColor: String!
    var greyLightColor: String!
    var greyLighterColor: String!
    
    init(defaultFont: FontInfo!,
         titleMainFont: FontInfo!,
         titleSecondaryFont: FontInfo!,
         searchResultTotalFont: FontInfo!,
         searchResultTitleFont: FontInfo!,
         resultTitleFont: FontInfo!,
         resultSubTitleFont: FontInfo!,
         profileTitleFont: FontInfo!,
         profileSubTitleFont: FontInfo!,
         profileTitleSectionFont: FontInfo!,
         cardTitleFont: FontInfo!,
         modalTitleFont: FontInfo!,
         searchInputFont: FontInfo!,
         sortCriteriaFont: FontInfo!,
         buttonFont: FontInfo!,
         smallFont: FontInfo!,
         primaryColor: String!,
         secondaryColor: String!,
         buttonBkgColor: String!,
         buttonAcceptBkgColor: String!,
         buttonDiscardBkgColor: String!,
         buttonBorderColor: String!,
         cardBorderColor: String!,
         markerColor: String!,
         markerSelectedColor: String!,
         viewBkgColor: String!,
         listBkgColor: String!,
         voteUpColor: String!,
         voteDownColor: String!,
         darkColor: String!,
         greyColor: String!,
         greyDarkColor: String!,
         greyDarkerColor: String!,
         greyLightColor: String!,
         greyLighterColor: String!) {
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Fonts
        defaultFont = try container.decode(FontInfo.self, forKey: .defaultFont)
        titleMainFont = try container.decode(FontInfo.self, forKey: .titleMainFont)
        titleSecondaryFont = try container.decode(FontInfo.self, forKey: .titleSecondaryFont)
        searchResultTotalFont = try container.decode(FontInfo.self, forKey: .searchResultTotalFont)
        searchResultTitleFont = try container.decode(FontInfo.self, forKey: .searchResultTitleFont)
        resultTitleFont = try container.decode(FontInfo.self, forKey: .resultTitleFont)
        resultSubTitleFont = try container.decode(FontInfo.self, forKey: .resultSubTitleFont)
        profileTitleFont = try container.decode(FontInfo.self, forKey: .profileTitleFont)
        profileSubTitleFont = try container.decode(FontInfo.self, forKey: .profileSubTitleFont)
        profileTitleSectionFont = try container.decode(FontInfo.self, forKey: .profileTitleSectionFont)
        cardTitleFont = try container.decode(FontInfo.self, forKey: .cardTitleFont)
        modalTitleFont = try container.decode(FontInfo.self, forKey: .modalTitleFont)
        searchInputFont = try container.decode(FontInfo.self, forKey: .searchInputFont)
        sortCriteriaFont = try container.decode(FontInfo.self, forKey: .sortCriteriaFont)
        buttonFont = try container.decode(FontInfo.self, forKey: .buttonFont)
        smallFont = try container.decode(FontInfo.self, forKey: .smallFont)
        
        // Colors
        primaryColor = try container.decode(String.self, forKey: .primaryColor)
        secondaryColor = try container.decode(String.self, forKey: .secondaryColor)
        buttonBkgColor = try container.decode(String.self, forKey: .buttonBkgColor)
        buttonAcceptBkgColor = try container.decode(String.self, forKey: .buttonAcceptBkgColor)
        buttonDiscardBkgColor = try container.decode(String.self, forKey: .buttonDiscardBkgColor)
        buttonBorderColor = try container.decode(String.self, forKey: .buttonBorderColor)
        cardBorderColor = try container.decode(String.self, forKey: .cardBorderColor)
        markerColor = try container.decode(String.self, forKey: .markerColor)
        markerSelectedColor = try container.decode(String.self, forKey: .markerSelectedColor)
        viewBkgColor = try container.decode(String.self, forKey: .viewBkgColor)
        listBkgColor = try container.decode(String.self, forKey: .listBkgColor)
        voteUpColor = try container.decode(String.self, forKey: .voteUpColor)
        voteDownColor = try container.decode(String.self, forKey: .voteDownColor)
        darkColor = try container.decode(String.self, forKey: .darkColor)
        greyColor = try container.decode(String.self, forKey: .greyColor)
        greyDarkColor = try container.decode(String.self, forKey: .greyDarkColor)
        greyDarkerColor = try container.decode(String.self, forKey: .greyDarkerColor)
        greyLightColor = try container.decode(String.self, forKey: .greyLightColor)
        greyLighterColor = try container.decode(String.self, forKey: .greyLighterColor)
    }
    
    func set(value: Any, for key: String) -> Theme? {
        if let data = try? JSONEncoder().encode(self) {
            var dictionary: [String: Any] = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]
            dictionary[key] = value
            if let newData = (try? JSONSerialization.data(withJSONObject: dictionary, options: .fragmentsAllowed)),
               let newTheme = try? JSONDecoder().decode(Theme.self, from: newData) {
                return newTheme
            }
        }
        return nil
    }
}
