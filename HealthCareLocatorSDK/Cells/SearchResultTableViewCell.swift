//
//  SearchResultTableViewCell.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/16/20.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconBgView: BaseView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    
    func configWith(theme: HCLThemeConfigure, iconImage: UIImage, title: String) {
        separatorView.backgroundColor = theme.greyLighterColor
        iconBgView.backgroundColor = theme.primaryColor.withAlphaComponent(0.1)
        icon.tintColor = theme.primaryColor
        resultTitleLabel.font = theme.defaultFont
        icon.image = iconImage
        resultTitleLabel.text = title
    }
}
