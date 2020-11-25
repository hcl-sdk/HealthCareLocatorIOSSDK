//
//  OKThemeConfigure.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation
import UIKit

public struct OKThemeConfigure {
    let primaryColor: UIColor!
    let secondaryColor: UIColor!
    let HCPThemeConfigure: OKHCPSearchConfigure!
    
    public init(primaryColor: UIColor? = UIColor(red: 67, green: 176, blue: 42, alpha: 1),
                secondaryColor: UIColor? = UIColor(red: 227, green: 243, blue: 223, alpha: 1),
                HCPThemeConfigure: OKHCPSearchConfigure? = OKHCPSearchConfigure(titleText: "Find and Locate\nHealthcare Professional",
                                                                                HCPSearch: OKIconTitleConfigure(image: UIImage(systemName: "magnifyingglass"),
                                                                                                                titleText: "Find and Locate other HCP",
                                                                                                                descriptionText: "Lorem ipsum dolor sit amet, consect adipiscing elit"),
                                                                                consultSearch: OKIconTitleConfigure(image: UIImage(systemName: "person"),
                                                                                                                    titleText: "Consult Profile",
                                                                                                                    descriptionText: "Lorem ipsum dolor sit amet, consect adipiscing elit"),
                                                                                informationUpdate: OKIconTitleConfigure(image: UIImage(systemName: "pencil"),
                                                                                                                        titleText: "Request my Information update",
                                                                                                                        descriptionText: "Lorem ipsum dolor sit amet, consect adipiscing elit"))) {
        guard let primaryColor = primaryColor,
              let secondaryColor = secondaryColor,
              let HCPThemeConfigure = HCPThemeConfigure else {
            fatalError("Can not init theme")
        }
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.HCPThemeConfigure = HCPThemeConfigure
    }
}
