//
//  IndividualAutoCompleteTableViewCell.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/15/20.
//

import UIKit

class IndividualAutoCompleteTableViewCell: UITableViewCell {
    @IBOutlet weak var individualNameLabel: UILabel!
    @IBOutlet weak var specialtiesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    @IBOutlet weak var separatorView: UIView!

    func configWith(theme: HCLThemeConfigure,
                    icons: HCLIconsConfigure,
                    individual: IndividualWorkPlaceDetails,
                    highlight: String?) {
        // Themes layout
        arrowIcon.image = icons.arrowRightIcon
        // Colors
        separatorView.backgroundColor = theme.greyLighterColor
        individualNameLabel.textColor = theme.secondaryColor
        specialtiesLabel.textColor = theme.darkColor
        addressLabel.textColor = theme.greyDarkColor
        arrowIcon.tintColor = theme.secondaryColor
        
        // Fonts
        individualNameLabel.font = theme.resultTitleFont
        specialtiesLabel.font = theme.smallFont
        addressLabel.font = theme.smallFont
        
        // Fullfill data
        specialtiesLabel.text = individual.professionalType?.label
        addressLabel.text = individual.mainActivity.workplace?.address.composedAddress
        
        let attibuteText = NSMutableAttributedString(string: individual.composedName)
        if let highlightText = highlight {
            let range = NSString(string: attibuteText.mutableString.lowercased).range(of: highlightText.lowercased())
            attibuteText.addAttribute(NSAttributedString.Key.foregroundColor, value: theme.primaryColor as Any, range: range)
        }
        individualNameLabel.attributedText = attibuteText
        
    }
    
}
