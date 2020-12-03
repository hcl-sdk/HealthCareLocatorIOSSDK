//
//  HCPConsultedHistoryTableViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/1/20.
//

import UIKit

class HCPConsultedHistoryTableViewCell: CustomBorderTableViewCell {
    
    @IBOutlet weak var drLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    weak var delegate: OKSearchHistoryDataSourceDelegate?
    
    func configWith(theme: OKThemeConfigure?, activity: Activity, isLastRow: Bool) {
        super.config(theme: theme, isLastRow: isLastRow)
        // Fonts
        drLabel.font = theme?.defaultFont
        categoryLabel.font = theme?.defaultFont
        addressLabel.font = theme?.defaultFont
        distanceLabel.font = theme?.smallFont
        
        // Colors
        drLabel.textColor = theme?.secondaryColor
        categoryLabel.textColor = theme?.darkColor
        distanceLabel.textColor = theme?.darkColor
        addressLabel.textColor = theme?.greyDarkColor
        
        //
        drLabel.text = activity.title.label
        categoryLabel.text = activity.workplace.name
        addressLabel.text = activity.workplace.address.longLabel
        distanceLabel.text = "3 days ago"
    }
    
    @IBAction func onRemoveAction(_ sender: Any) {
        if let indexPath = indexPath {
            delegate?.shouldRemoveActivityAt(indexPath: indexPath)
        }
    }
}
