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
                              borderColor: selected ? (theme.markerSelectedColor ?? .red) : (theme.cardBorderColor ?? .darkGray))
        // Icons
        moreDetailIcon.image = icons.arrowRightIcon
        
        // Fonts
        drLabel.font = theme.resultTitleFont
        categoryLabel.font = theme.defaultFont
        parentWorkplaceLabel.font = theme.defaultFont
        addressLabel.font = theme.defaultFont
        distanceLabel.font = theme.defaultFont
        
        // Colors
        wrapper.backgroundColor = theme.darkmode ? kDarkLightColor : .white
        drLabel.textColor = theme.secondaryColor
        moreDetailIcon.tintColor = theme.secondaryColor
        parentWorkplaceLabel.textColor = theme.darkmode ? .white : theme.darkColor
        categoryLabel.textColor = theme.darkmode ? .white : theme.darkColor
        addressLabel.textColor = theme.greyDarkColor
        distanceLabel.textColor = theme.darkmode ? .white : theme.darkColor
        
        drLabel.text = item.activity.individual.composedName
        categoryLabel.text = item.activity.individual.specialties.first?.label
        addressLabel.text = item.activity.workplace.address.composedAddress
        guard let dis = item.distance, dis > 0 else {
            distanceLabel.text = ""
            return
        }
        let disUnit = dis / kDefaultDistanceUnit.toMeter
        let disUnitText = disUnit >= 1 ? (kDefaultDistanceUnit == .km ? "km" : "mi") : (kDefaultDistanceUnit == .km ? "m" : "ft")
        distanceLabel.text = "\(String(format: "%.1f", disUnit >= 1 ? disUnit : dis)) \(disUnitText)"
    }
}
