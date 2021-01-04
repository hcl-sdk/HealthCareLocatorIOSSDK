//
//  OKHomeViewModel.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/25/20.
//

import Foundation
import UIKit

class SearchHomeViewModel {
    func layout(view: SearchHomeViewController, with theme: OKThemeConfigure) {
        view.headerTitleLabel.text = "onekey_sdk_home_title".localized
        view.bottomSearchBtn.setTitle("onekey_sdk_start_new_search".localized, for: .normal)
        // Colors
        view.view.backgroundColor = theme.viewBkgColor
        view.searchTextField.textColor = theme.darkColor
        view.searchTextField.attributedPlaceholder = NSAttributedString(string: "onekey_sdk_find_healthcare_professional".localized,
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
                                       image: UIImage(named: "magnifier", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate),
                                       title: "onekey_sdk_home_feat_find_hcp_title".localized,
                                       description: "Lorem ipsum dolor sit amet, consect adipiscing elit")
        view.bodyContentWrapper.addArrangedSubview(HCPView)
        
        let consultView = SearchTypeView(theme: theme,
                                           image: UIImage(named: "profile", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate),
                                           title: "onekey_sdk_home_feat_consult_profile_title".localized,
                                           description: "Lorem ipsum dolor sit amet, consect adipiscing elit")
        view.bodyContentWrapper.addArrangedSubview(consultView)
        
        let informationView = SearchTypeView(theme: theme,
                                               image: UIImage(named: "edit", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate),
                                               title: "onekey_sdk_home_feat_request_info_update_title".localized,
                                               description: "Lorem ipsum dolor sit amet, consect adipiscing elit")
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
