//
//  OKHomeViewModel.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/25/20.
//

import Foundation
import UIKit

class SearchHomeViewModel {
    func layout(view: SearchHomeViewController, with theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        view.headerTitleLabel.text = "hcl_home_title".localized
        view.bottomSearchBtn.setTitle("hcl_start_new_search".localized, for: .normal)
        view.topSearchBtn.setImage(icons.searchIcon, for: .normal)
        
        // Colors
        view.view.backgroundColor = theme.viewBkgColor
        view.searchTextFieldWrapper.borderColor = theme.cardBorderColor
        view.searchTextField.textColor = theme.darkColor
        view.searchTextField.attributedPlaceholder = NSAttributedString(string: "hcl_find_healthcare_professional".localized,
                                                                   attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        view.contentWrapperView.borderColor = theme.cardBorderColor
        view.headerTitleLabel.textColor = theme.secondaryColor
        view.bottomSearchBtn.backgroundColor = theme.primaryColor
        view.topSearchBtn.backgroundColor = theme.primaryColor

        // Fonts
        view.headerTitleLabel.font = theme.titleMainFont
        view.searchTextField.font = theme.searchInputFont
        view.bottomSearchBtn.titleLabel?.font = theme.defaultFont
        
        //
        for subView in view.bodyContentWrapper.arrangedSubviews {
            subView.removeFromSuperview()
            view.bodyContentWrapper.removeArrangedSubview(subView)
        }
        
        let HCPView = SearchTypeView(theme: theme,
                                     image: icons.searchIcon.withRenderingMode(.alwaysTemplate),
                                       title: "hcl_home_feat_find_hcp_title".localized,
                                       description: "hcl_home_feat_find_hcp_text".localized)
        view.bodyContentWrapper.addArrangedSubview(HCPView)
        
        let consultView = SearchTypeView(theme: theme,
                                         image: icons.profileIcon.withRenderingMode(.alwaysTemplate),
                                           title: "hcl_home_feat_consult_profile_title".localized,
                                           description: "hcl_home_feat_consult_profile_text".localized)
        view.bodyContentWrapper.addArrangedSubview(consultView)
        
        let informationView = SearchTypeView(theme: theme,
                                             image: icons.editIcon.withRenderingMode(.alwaysTemplate),
                                               title: "hcl_home_feat_request_info_update_title".localized,
                                               description: "hcl_home_feat_request_info_update_text".localized)
        view.bodyContentWrapper.addArrangedSubview(informationView)
    }
    
    func layout(view: SearchHomeViewController, with traitCollection: UITraitCollection) {
        for subview in view.bodyContentWrapper.arrangedSubviews {
            if let searchTypeView = subview as? SearchTypeView {
                searchTypeView.layoutWith(traitCollection: traitCollection)
            }
        }
    }
}
