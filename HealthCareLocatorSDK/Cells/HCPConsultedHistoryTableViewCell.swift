//
//  HCPConsultedHistoryTableViewCell.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/1/20.
//

import UIKit

class HCPConsultedHistoryTableViewCell: CustomBorderTableViewCell {
    
    @IBOutlet weak var drLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    weak var delegate: SearchHistoryCellDelegate?
    
    func configWith(theme: HCLThemeConfigure?, icons: HCLIconsConfigure, lang: String,  activity: LastHCPConsulted, isLastRow: Bool) {
        super.config(theme: theme, isLastRow: isLastRow)
        closeButton.setImage(icons.crossIcon, for: .normal)
        
        // Fonts
        drLabel.font = theme?.defaultFont
        categoryLabel.font = theme?.defaultFont
        addressLabel.font = theme?.defaultFont
        distanceLabel.font = theme?.smallFont
        
        // Colors
        closeButton.tintColor = theme?.greyDarkColor
        drLabel.textColor = theme?.secondaryColor
        categoryLabel.textColor = theme?.darkColor
        distanceLabel.textColor = theme?.darkColor
        addressLabel.textColor = theme?.greyDarkColor

        //
        drLabel.text = activity.activity.individual.composedName
        categoryLabel.text = activity.activity.individual.specialties.first?.label
        addressLabel.text = activity.activity.workplace.address.longLabel
        distanceLabel.text = String(format: "hcl_since_format".localized, Date(timeIntervalSince1970: activity.timeInterval).timeAgo(locale: lang))
    }
    
    @IBAction func onRemoveAction(_ sender: Any) {
        if let indexPath = indexPath {
            delegate?.shouldRemoveActivityAt(indexPath: indexPath)
        }
    }
}
