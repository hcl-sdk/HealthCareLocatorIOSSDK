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
    
    func configWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure, item: ActivityResult, selected: Bool) {
        wrapperView.setBorderWith(width: selected ? 2 : 1,
                              cornerRadius: 8,
                              borderColor: selected ? (theme.markerSelectedColor ?? .red) : (theme.cardBorderColor ?? .lightGray))
        // Icons
        moreDetailIcon.image = icons.arrowRightIcon
        
        // Fonts
        drLabel.font = theme.resultTitleFont
        categoryLabel.font = theme.resultSubTitleFont
        addressLabel.font = theme.resultSubTitleFont
        distanceLabel.font = theme.resultSubTitleFont
        
        // Colors
        wrapperView.backgroundColor = theme.darkmode ? kDarkLightColor : .white
        drLabel.textColor = theme.secondaryColor
        categoryLabel.textColor = theme.darkColor
        addressLabel.textColor = theme.greyDarkColor
        distanceLabel.textColor = theme.darkColor
        moreDetailIcon.tintColor = theme.secondaryColor
        
        //
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
