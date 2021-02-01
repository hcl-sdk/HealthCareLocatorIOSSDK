//
//  HomeFullViewModel.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/25/20.
//

import Foundation
import UIKit

class HomeFullViewModel {
    func layout(view: SearchHomeFullViewController, with theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        view.searchBtn.setImage(icons.searchIcon, for: .normal)
        
        // Colors
        view.view.backgroundColor = theme.viewBkgColor
        view.separatorView.backgroundColor = theme.cardBorderColor
        view.searchBtn.backgroundColor = theme.primaryColor
        view.searchTextField.textColor = theme.darkColor
        view.searchTextField.attributedPlaceholder = NSAttributedString(string: "hcl_find_healthcare_professional".localized,
                                                                   attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        // Fonts
        view.searchTextField.font = theme.searchInputFont
        view.tableViewDataSource.layoutWith(theme: theme, icons: icons)
    }
}
