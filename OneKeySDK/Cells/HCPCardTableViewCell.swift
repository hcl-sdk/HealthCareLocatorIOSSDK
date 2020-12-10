//
//  HCPCardTableViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/23/20.
//

import UIKit

class HCPCardTableViewCell: UITableViewCell {

    @IBOutlet weak var wrapperView: OKBaseView!
    @IBOutlet weak var drLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var moreDetailIcon: UIImageView!
    
    func configWith(theme: OKThemeConfigure?, item: Activity) {
        // Fonts
        drLabel.font = theme?.resultTitleFont
        categoryLabel.font = theme?.resultSubTitleFont
        addressLabel.font = theme?.resultSubTitleFont
        distanceLabel.font = theme?.resultSubTitleFont
        
        // Colors
        wrapperView.borderColor = theme?.cardBorderColor ?? .lightGray
        drLabel.textColor = theme?.secondaryColor
        categoryLabel.textColor = theme?.darkColor
        addressLabel.textColor = theme?.greyDarkColor
        distanceLabel.textColor = theme?.darkColor
        moreDetailIcon.tintColor = theme?.secondaryColor
        
        //
        drLabel.text = item.title.label
        categoryLabel.text = item.workplace.name
        addressLabel.text = item.workplace.address.longLabel
        distanceLabel.text = "500m"
    }
}
