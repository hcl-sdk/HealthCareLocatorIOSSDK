//
//  HCPCardTableViewCell.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/23/20.
//

import UIKit

class HCPCardTableViewCell: UITableViewCell {

    @IBOutlet weak var wrapperView: BaseView!
    @IBOutlet weak var drLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var moreDetailIcon: UIImageView!
    
    func configWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure, item: ActivityResult) {
        // Icons
        moreDetailIcon.image = icons.arrowRightIcon
        
        // Fonts
        drLabel.font = theme.resultTitleFont
        categoryLabel.font = theme.resultSubTitleFont
        addressLabel.font = theme.resultSubTitleFont
        distanceLabel.font = theme.resultSubTitleFont
        
        // Colors
        wrapperView.borderColor = theme.cardBorderColor ?? .lightGray
        drLabel.textColor = theme.secondaryColor
        categoryLabel.textColor = theme.darkColor
        addressLabel.textColor = theme.greyDarkColor
        distanceLabel.textColor = theme.darkColor
        moreDetailIcon.tintColor = theme.secondaryColor
        
        //
        drLabel.text = item.activity.individual.composedName
        categoryLabel.text = item.activity.individual.professionalType?.label
        addressLabel.text = item.activity.workplace.address.composedAddress
        let distance = Int(item.distance ?? 0)
        if distance > 0 {
            distanceLabel.text = String(format: "hcl_distance_unit".localized, distance)
        } else {
            distanceLabel.isHidden = true
        }
    }
}
