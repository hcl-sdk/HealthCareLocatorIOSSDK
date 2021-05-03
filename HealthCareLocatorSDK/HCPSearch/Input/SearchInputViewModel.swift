//
//  SearchInputViewModel.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/25/20.
//

import Foundation
import UIKit

class SearchInputViewModel {
    func layout(view: SearchInputViewController, with theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        view.searchBtn.setImage(icons.searchIcon, for: .normal)
        
        // Colors
        view.backButton.tintColor = theme.darkColor
        view.separatorView.backgroundColor = theme.greyLighterColor
        view.searchResultTableView.separatorColor = theme.greyLighterColor
        
        view.categorySearchTextField.attributedPlaceholder = NSAttributedString(string: "hcl_search_first_field_label".localized,
                                                                   attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        view.locationSearchTextField.attributedPlaceholder = NSAttributedString(string: "hcl_search_second_field_label".localized,
                                                                   attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        view.categorySearchTextField.textColor = theme.darkColor
        view.locationSearchTextField.textColor = theme.darkColor
        
        view.searchBtn.backgroundColor = theme.primaryColor
        
        // Fonts
        view.categorySearchTextField.font = theme.searchInputFont
        view.locationSearchTextField.font = theme.searchInputFont
    }
    
    func showLoading(isLoading: Bool, for field: UITextField) {
        if isLoading {
            let indicator = UIActivityIndicatorView(style: .gray)
            field.rightView = indicator
            indicator.startAnimating()
        } else {
            field.rightView = nil
        }
    }
}
