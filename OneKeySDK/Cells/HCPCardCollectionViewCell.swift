//
//  HCPCardCollectionViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/18/20.
//

import UIKit

class HCPCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wrapper: OKBaseView!
    @IBOutlet weak var drLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var parentWorkplaceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var moreDetailIcon: UIImageView!
    
    func configWith(theme: OKThemeConfigure?, item: ActivityResult, selected: Bool) {
        wrapper.setBorderWith(width: selected ? 2 : 0,
                              cornerRadius: 8,
                              borderColor: selected ? (theme?.markerSelectedColor ?? UIColor.red) : UIColor.clear )
        
        // Fonts
        drLabel.font = theme?.resultTitleFont
        categoryLabel.font = theme?.defaultFont
        parentWorkplaceLabel.font = theme?.defaultFont
        addressLabel.font = theme?.defaultFont
        distanceLabel.font = theme?.defaultFont
        
        // Colors
        drLabel.textColor = theme?.secondaryColor
        moreDetailIcon.tintColor = theme?.secondaryColor
        parentWorkplaceLabel.textColor = theme?.darkColor
        categoryLabel.textColor = theme?.darkColor
        addressLabel.textColor = theme?.greyDarkColor
        distanceLabel.textColor = theme?.darkColor
        
        drLabel.text = item.activity.individual.composedName
        categoryLabel.text = item.activity.individual.specialties.first?.label
        addressLabel.text = item.activity.workplace.address.composedAddress
//        parentWorkplaceLabel.text = item.activity.workplace
        distanceLabel.text = "500m"
    }
}
