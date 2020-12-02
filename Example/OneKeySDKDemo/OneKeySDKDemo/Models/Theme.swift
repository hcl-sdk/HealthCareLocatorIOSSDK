//
//  Theme.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/13/20.
//

import Foundation
import UIKit

struct Theme: Codable, Equatable {
    
    private static let defaultSystemFont = UIFont(name: "Helvetica", size: 14.0)!
    private static let defaultSystemBoldFont = UIFont(name: "HelveticaNeue-Medium", size: 14.0)!
        
    // Fonts - Default
    let defaultFontName: String!
    let defaultFontSize: CGFloat!
    var defaultFont: UIFont {
        return UIFont(name: defaultFontName, size: defaultFontSize)!
    }
    
    // Fonts - Title 1
    let title1FontName: String!
    let title1FontSize: CGFloat!
    var title1Font: UIFont {
        return UIFont(name: title1FontName, size: title1FontSize)!
    }
    
    // Fonts - Title 2
    let title2FontName: String!
    let title2FontSize: CGFloat!
    var title2Font: UIFont {
        return UIFont(name: title2FontName, size: title2FontSize)!
    }
    
    // Fonts - Title 3
    let title3FontName: String!
    let title3FontSize: CGFloat!
    var title3Font: UIFont {
        return UIFont(name: title3FontName, size: title3FontSize)!
    }
    
    // Fonts - Title 4
//    let title4FontName: String!
//    let title4FontSize: CGFloat!
//    var title4Font: UIFont {
//        return UIFont(name: title4FontName, size: title4FontSize)!
//    }
//
//    // Fonts - Title 4
//    let titleModalFontName: String!
//    let titleModalFontSize: CGFloat!
//    var titleModalFont: UIFont {
//        return UIFont(name: titleModalFontName, size: titleModalFontSize)!
//    }
    
    // Fonts - Title
    let searchInputFontName: String!
    let searchInputFontSize: CGFloat!
    var searchInputFont: UIFont {
        return UIFont(name: searchInputFontName, size: searchInputFontSize)!
    }
    
    // Fonts - Title
    let buttonFontName: String!
    let buttonFontSize: CGFloat!
    var buttonFont: UIFont {
        return UIFont(name: buttonFontName, size: buttonFontSize)!
    }
    
    // Fonts - Title
    let smallFontName: String!
    let smallFontSize: CGFloat!
    var smallFont: UIFont {
        return UIFont(name: smallFontName, size: smallFontSize)!
    }
    
    // Fonts - Title
//    let bigFontName: String!
//    let bigFontSize: CGFloat!
//    var bigFont: UIFont {
//        return UIFont(name: bigFontName, size: bigFontSize)!
//    }
    
    // Colors
    let primaryColorHex: String!
    let secondaryColorHex: String!
    let markerColorHex: String!
    let selectedMarkerColorHex: String!
    let listBackgroundColorHex: String!

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        defaultFontName = try container.decode(String.self, forKey: .defaultFontName)
        defaultFontSize = try container.decode(CGFloat.self, forKey: .defaultFontSize)
        title1FontName = try container.decode(String.self, forKey: .title1FontName)
        title1FontSize = try container.decode(CGFloat.self, forKey: .title1FontSize)
        title2FontName = try container.decode(String.self, forKey: .title2FontName)
        title2FontSize = try container.decode(CGFloat.self, forKey: .title2FontSize)
        title3FontName = try container.decode(String.self, forKey: .title3FontName)
        title3FontSize = try container.decode(CGFloat.self, forKey: .title3FontSize)
//        title4FontName = try container.decode(String.self, forKey: .title4FontName)
//        title4FontSize = try container.decode(CGFloat.self, forKey: .title4FontSize)
//        titleModalFontName = try container.decode(String.self, forKey: .titleModalFontName)
//        titleModalFontSize = try container.decode(CGFloat.self, forKey: .titleModalFontSize)
        searchInputFontName = try container.decode(String.self, forKey: .searchInputFontName)
        searchInputFontSize = try container.decode(CGFloat.self, forKey: .searchInputFontSize)
        buttonFontName = try container.decode(String.self, forKey: .buttonFontName)
        buttonFontSize = try container.decode(CGFloat.self, forKey: .buttonFontSize)
        smallFontName = try container.decode(String.self, forKey: .smallFontName)
        smallFontSize = try container.decode(CGFloat.self, forKey: .smallFontSize)
//        bigFontName = try container.decode(String.self, forKey: .bigFontName)
//        bigFontSize = try container.decode(CGFloat.self, forKey: .bigFontSize)
        primaryColorHex = try container.decode(String.self, forKey: .primaryColorHex)
        secondaryColorHex = try container.decode(String.self, forKey: .secondaryColorHex)
        markerColorHex = try container.decode(String.self, forKey: .markerColorHex)
        selectedMarkerColorHex = try container.decode(String.self, forKey: .selectedMarkerColorHex)
        listBackgroundColorHex = try container.decode(String.self, forKey: .listBackgroundColorHex)
    }
    
    init(defaultFontName: String!,
         defaultFontSize: CGFloat!,
         title1FontName: String!,
         title1FontSize: CGFloat!,
         title2FontName: String!,
         title2FontSize: CGFloat!,
         title3FontName: String!,
         title3FontSize: CGFloat!,
         searchInputFontName: String!,
         searchInputFontSize: CGFloat!,
         buttonFontName: String!,
         buttonFontSize: CGFloat!,
         smallFontName: String!,
         smallFontSize: CGFloat!,
         primaryColorHex: String!,
         secondaryColorHex: String!,
         markerColorHex: String!,
         selectedMarkerColorHex: String!,
         listBackgroundColorHex: String!) {
        self.defaultFontName = defaultFontName
        self.defaultFontSize = defaultFontSize
        self.title1FontName = title1FontName
        self.title1FontSize = title1FontSize
        self.title2FontName = title2FontName
        self.title2FontSize = title2FontSize
        self.title3FontName = title3FontName
        self.title3FontSize = title3FontSize
        self.searchInputFontName = searchInputFontName
        self.searchInputFontSize = searchInputFontSize
        self.buttonFontName = buttonFontName
        self.buttonFontSize = buttonFontSize
        self.smallFontName = smallFontName
        self.smallFontSize = smallFontSize
        self.primaryColorHex = primaryColorHex
        self.secondaryColorHex = secondaryColorHex
        self.markerColorHex = markerColorHex
        self.selectedMarkerColorHex = selectedMarkerColorHex
        self.listBackgroundColorHex = listBackgroundColorHex
    }
    
    static let defaultGreenTheme = Theme(defaultFontName: Theme.defaultSystemFont.fontName,
                                         defaultFontSize: 14.0,
                                         title1FontName: Theme.defaultSystemFont.fontName,
                                         title1FontSize: 20.0,
                                         title2FontName: Theme.defaultSystemFont.fontName,
                                         title2FontSize: 16.0,
                                         title3FontName: Theme.defaultSystemFont.fontName,
                                         title3FontSize: 14.0,
                                         searchInputFontName: Theme.defaultSystemFont.fontName,
                                         searchInputFontSize: 16.0,
                                         buttonFontName: Theme.defaultSystemFont.fontName,
                                         buttonFontSize: 14.0,
                                         smallFontName: Theme.defaultSystemFont.fontName,
                                         smallFontSize: 12.0,
                                         primaryColorHex: "43B12B",
                                         secondaryColorHex: "00A3E0",
                                         markerColorHex: "FE8A12",
                                         selectedMarkerColorHex: "CD0800",
                                         listBackgroundColorHex: "f8f9fa")
    
    static let defaultBlueTheme = Theme(defaultFontName: Theme.defaultSystemFont.fontName,
                                        defaultFontSize: 14.0,
                                        title1FontName: Theme.defaultSystemFont.fontName,
                                        title1FontSize: 20.0,
                                        title2FontName: Theme.defaultSystemFont.fontName,
                                        title2FontSize: 16.0,
                                        title3FontName: Theme.defaultSystemFont.fontName,
                                        title3FontSize: 14.0,
                                        searchInputFontName: Theme.defaultSystemFont.fontName,
                                        searchInputFontSize: 16.0,
                                        buttonFontName: Theme.defaultSystemFont.fontName,
                                        buttonFontSize: 14.0,
                                        smallFontName: Theme.defaultSystemFont.fontName,
                                        smallFontSize: 12.0,
                                        primaryColorHex: "0433CC",
                                        secondaryColorHex: "00A3E0",
                                        markerColorHex: "1A53FF",
                                        selectedMarkerColorHex: "000D33",
                                        listBackgroundColorHex: "f8f9fa")
    
    static let defaultRedTheme = Theme(defaultFontName: Theme.defaultSystemFont.fontName,
                                       defaultFontSize: 14.0,
                                       title1FontName: Theme.defaultSystemFont.fontName,
                                       title1FontSize: 20.0,
                                       title2FontName: Theme.defaultSystemFont.fontName,
                                       title2FontSize: 16.0,
                                       title3FontName: Theme.defaultSystemFont.fontName,
                                       title3FontSize: 14.0,
                                       searchInputFontName: Theme.defaultSystemFont.fontName,
                                       searchInputFontSize: 16.0,
                                       buttonFontName: Theme.defaultSystemFont.fontName,
                                       buttonFontSize: 14.0,
                                       smallFontName: Theme.defaultSystemFont.fontName,
                                       smallFontSize: 12.0,
                                       primaryColorHex: "FD0D00",
                                       secondaryColorHex: "00A3E0",
                                       markerColorHex: "FD3334",
                                       selectedMarkerColorHex: "4D0100",
                                       listBackgroundColorHex: "f8f9fa")
    
    static let defaultPurpleTheme = Theme(defaultFontName: Theme.defaultSystemFont.fontName,
                                          defaultFontSize: 14.0,
                                          title1FontName: Theme.defaultSystemFont.fontName,
                                          title1FontSize: 20.0,
                                          title2FontName: Theme.defaultSystemFont.fontName,
                                          title2FontSize: 16.0,
                                          title3FontName: Theme.defaultSystemFont.fontName,
                                          title3FontSize: 14.0,
                                          searchInputFontName: Theme.defaultSystemFont.fontName,
                                          searchInputFontSize: 16.0,
                                          buttonFontName: Theme.defaultSystemFont.fontName,
                                          buttonFontSize: 14.0,
                                          smallFontName: Theme.defaultSystemFont.fontName,
                                          smallFontSize: 12.0,
                                          primaryColorHex: "771d5f",
                                          secondaryColorHex: "00A3E0",
                                          markerColorHex: "a33c9f",
                                          selectedMarkerColorHex: "690f65",
                                          listBackgroundColorHex: "f8f9fa")
}

extension Theme {
    func change(font: UIFont, for desc: String) -> Theme? {
        switch desc {
        case kMenuCustomThemeFontsDefaultTitle:
            return Theme(defaultFontName: font.fontName,
                         defaultFontSize: font.pointSize,
                         title1FontName: title1FontName,
                         title1FontSize: title1FontSize,
                         title2FontName: title2FontName,
                         title2FontSize: title2FontSize,
                         title3FontName: title3FontName,
                         title3FontSize: title3FontSize,
                         searchInputFontName: searchInputFontName,
                         searchInputFontSize: searchInputFontSize,
                         buttonFontName: buttonFontName,
                         buttonFontSize: buttonFontSize,
                         smallFontName: smallFontName,
                         smallFontSize: smallFontSize,
                         primaryColorHex: primaryColorHex,
                         secondaryColorHex: secondaryColorHex,
                         markerColorHex: markerColorHex,
                         selectedMarkerColorHex: selectedMarkerColorHex,
                         listBackgroundColorHex: listBackgroundColorHex)
        case kMenuCustomThemeFontsTitle1Title:
            return Theme(defaultFontName: defaultFontName,
                         defaultFontSize: defaultFontSize,
                         title1FontName: font.fontName,
                         title1FontSize: font.pointSize,
                         title2FontName: title2FontName,
                         title2FontSize: title2FontSize,
                         title3FontName: title3FontName,
                         title3FontSize: title3FontSize,
                         searchInputFontName: searchInputFontName,
                         searchInputFontSize: searchInputFontSize,
                         buttonFontName: buttonFontName,
                         buttonFontSize: buttonFontSize,
                         smallFontName: smallFontName,
                         smallFontSize: smallFontSize,
                         primaryColorHex: primaryColorHex,
                         secondaryColorHex: secondaryColorHex,
                         markerColorHex: markerColorHex,
                         selectedMarkerColorHex: selectedMarkerColorHex,
                         listBackgroundColorHex: listBackgroundColorHex)
        case kMenuCustomThemeFontsTitle2Title:
            return Theme(defaultFontName:  defaultFontName,
                         defaultFontSize: defaultFontSize,
                         title1FontName: title1FontName,
                         title1FontSize: title1FontSize,
                         title2FontName: font.fontName,
                         title2FontSize: font.pointSize,
                         title3FontName: title3FontName,
                         title3FontSize: title3FontSize,
                         searchInputFontName: searchInputFontName,
                         searchInputFontSize: searchInputFontSize,
                         buttonFontName: buttonFontName,
                         buttonFontSize: buttonFontSize,
                         smallFontName: smallFontName,
                         smallFontSize: smallFontSize,
                         primaryColorHex: primaryColorHex,
                         secondaryColorHex: secondaryColorHex,
                         markerColorHex: markerColorHex,
                         selectedMarkerColorHex: selectedMarkerColorHex,
                         listBackgroundColorHex: listBackgroundColorHex)
        case kMenuCustomThemeFontsTitle3Title:
            return Theme(defaultFontName:  defaultFontName,
                         defaultFontSize: defaultFontSize,
                         title1FontName: title1FontName,
                         title1FontSize: title1FontSize,
                         title2FontName: title2FontName,
                         title2FontSize: title2FontSize,
                         title3FontName: font.fontName,
                         title3FontSize: font.pointSize,
                         searchInputFontName: searchInputFontName,
                         searchInputFontSize: searchInputFontSize,
                         buttonFontName: buttonFontName,
                         buttonFontSize: buttonFontSize,
                         smallFontName: smallFontName,
                         smallFontSize: smallFontSize,
                         primaryColorHex: primaryColorHex,
                         secondaryColorHex: secondaryColorHex,
                         markerColorHex: markerColorHex,
                         selectedMarkerColorHex: selectedMarkerColorHex,
                         listBackgroundColorHex: listBackgroundColorHex)
        case kMenuCustomThemeFontsSearchInputTitle:
            return Theme(defaultFontName:  defaultFontName,
                         defaultFontSize: defaultFontSize,
                         title1FontName: title1FontName,
                         title1FontSize: title1FontSize,
                         title2FontName: title2FontName,
                         title2FontSize: title2FontSize,
                         title3FontName: title3FontName,
                         title3FontSize: title3FontSize,
                         searchInputFontName: font.fontName,
                         searchInputFontSize: font.pointSize,
                         buttonFontName: buttonFontName,
                         buttonFontSize: buttonFontSize,
                         smallFontName: smallFontName,
                         smallFontSize: smallFontSize,
                         primaryColorHex: primaryColorHex,
                         secondaryColorHex: secondaryColorHex,
                         markerColorHex: markerColorHex,
                         selectedMarkerColorHex: selectedMarkerColorHex,
                         listBackgroundColorHex: listBackgroundColorHex)
        case kMenuCustomThemeFontsButtonTitle:
            return Theme(defaultFontName:  defaultFontName,
                         defaultFontSize: defaultFontSize,
                         title1FontName: title1FontName,
                         title1FontSize: title1FontSize,
                         title2FontName: title2FontName,
                         title2FontSize: title2FontSize,
                         title3FontName: title3FontName,
                         title3FontSize: title3FontSize,
                         searchInputFontName: searchInputFontName,
                         searchInputFontSize: searchInputFontSize,
                         buttonFontName: font.fontName,
                         buttonFontSize: font.pointSize,
                         smallFontName: smallFontName,
                         smallFontSize: smallFontSize,
                         primaryColorHex: primaryColorHex,
                         secondaryColorHex: secondaryColorHex,
                         markerColorHex: markerColorHex,
                         selectedMarkerColorHex: selectedMarkerColorHex,
                         listBackgroundColorHex: listBackgroundColorHex)
        case kMenuCustomThemeFontsSmallTitle:
            return Theme(defaultFontName:  defaultFontName,
                         defaultFontSize: defaultFontSize,
                         title1FontName: title1FontName,
                         title1FontSize: title1FontSize,
                         title2FontName: title2FontName,
                         title2FontSize: title2FontSize,
                         title3FontName: title3FontName,
                         title3FontSize: title3FontSize,
                         searchInputFontName: searchInputFontName,
                         searchInputFontSize: searchInputFontSize,
                         buttonFontName: buttonFontName,
                         buttonFontSize: buttonFontSize,
                         smallFontName: font.fontName,
                         smallFontSize: font.pointSize,
                         primaryColorHex: primaryColorHex,
                         secondaryColorHex: secondaryColorHex,
                         markerColorHex: markerColorHex,
                         selectedMarkerColorHex: selectedMarkerColorHex,
                         listBackgroundColorHex: listBackgroundColorHex)
        default:
            return nil
        }
    }
}
