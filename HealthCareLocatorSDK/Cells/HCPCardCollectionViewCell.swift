//
//  HCPCardCollectionViewCell.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/18/20.
//

import UIKit

class HCPCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wrapper: BaseView!
    @IBOutlet weak var drLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var parentWorkplaceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var moreDetailIcon: UIImageView!
    
    func configWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure, item: ActivityResult, selected: Bool) {
        wrapper.setBorderWith(width: selected ? 2 : 1,
                              cornerRadius: 8,
                              borderColor: selected ? (theme.markerSelectedColor ?? UIColor.red) : (theme.cardBorderColor ?? UIColor.darkGray))
        // Icons
        moreDetailIcon.image = icons.arrowRightIcon
        
        // Fonts
        drLabel.font = theme.resultTitleFont
        categoryLabel.font = theme.defaultFont
        parentWorkplaceLabel.font = theme.defaultFont
        addressLabel.font = theme.defaultFont
        distanceLabel.font = theme.defaultFont
        
        // Colors
        drLabel.textColor = theme.secondaryColor
        moreDetailIcon.tintColor = theme.secondaryColor
        parentWorkplaceLabel.textColor = theme.darkColor
        categoryLabel.textColor = theme.darkColor
        addressLabel.textColor = theme.greyDarkColor
        distanceLabel.textColor = theme.darkColor
        
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
