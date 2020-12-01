//
//  Theme.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/13/20.
//

import Foundation
import UIKit

struct Theme: Encodable, Decodable, Equatable {
    
    private static let defaultSystemFont = UIFont(name: "Helvetica", size: 14.0)!
        
    // Fonts - Default
    let defaultFontName: String!
    let defaultFontSize: CGFloat!
    
    // Fonts - Title
    let titleFontName: String!
    let titleFontSize: CGFloat!
    
    // Colors
    let primaryColorHex: String!
    let secondaryColorHex: String!
    let markerColorHex: String!
    let selectedMarkerColorHex: String!
    
    static let defaultGreenTheme = Theme(defaultFontName: Theme.defaultSystemFont.fontName,
                                         defaultFontSize: 14.0,
                                         titleFontName: Theme.defaultSystemFont.fontName,
                                         titleFontSize: 20.0,
                                         primaryColorHex: "43B12B",
                                         secondaryColorHex: "00A3E0",
                                         markerColorHex: "FE8A12",
                                         selectedMarkerColorHex: "CD0800")
    
    static let defaultBlueTheme = Theme(defaultFontName: Theme.defaultSystemFont.fontName,
                                        defaultFontSize: 14.0,
                                        titleFontName: Theme.defaultSystemFont.fontName,
                                        titleFontSize: 20.0,
                                        primaryColorHex: "0433CC",
                                        secondaryColorHex: "00A3E0",
                                        markerColorHex: "1A53FF",
                                        selectedMarkerColorHex: "000D33")
    
    static let defaultRedTheme = Theme(defaultFontName: Theme.defaultSystemFont.fontName,
                                       defaultFontSize: 14.0,
                                       titleFontName: Theme.defaultSystemFont.fontName,
                                       titleFontSize: 20.0,
                                       primaryColorHex: "FD0D00",
                                       secondaryColorHex: "00A3E0",
                                       markerColorHex: "FD3334",
                                       selectedMarkerColorHex: "4D0100")
    
    static let defaultPurpleTheme = Theme(defaultFontName: Theme.defaultSystemFont.fontName,
                                          defaultFontSize: 14.0,
                                          titleFontName: Theme.defaultSystemFont.fontName,
                                          titleFontSize: 20.0,
                                          primaryColorHex: "771d5f",
                                          secondaryColorHex: "00A3E0",
                                          markerColorHex: "a33c9f",
                                          selectedMarkerColorHex: "690f65")
}
