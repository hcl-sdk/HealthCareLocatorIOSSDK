//
//  SearchResultTableViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/16/20.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconBgView: OKBaseView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var resultTitleLabel: UILabel!
    
    
    func configWith(theme: OKThemeConfigure, iconImage: UIImage, title: String) {
        iconBgView.backgroundColor = theme.secondaryColor
        resultTitleLabel.font = theme.defaultFont
        icon.tintColor = theme.primaryColor
        icon.image = iconImage
        resultTitleLabel.text = title
    }
}
