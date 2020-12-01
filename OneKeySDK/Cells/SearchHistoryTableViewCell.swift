//
//  SearchHistoryTableViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/1/20.
//

import UIKit

class SearchHistoryTableViewCell: CustomBorderTableViewCell {
    @IBOutlet weak var criteriabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    weak var delegate: OKSearchHistoryDataSourceDelegate?

    func configWith(theme: OKThemeConfigure?, search: OKHCPLastSearch, isLastRow: Bool) {
        super.config(isLastRow: isLastRow)
        // Fonts
        criteriabel.font = theme?.defaultFont
        addressLabel.font = theme?.defaultFont
        timeLabel.font = theme?.defaultFont
        categoryLabel.font = theme?.defaultFont
        
        // Colors
        criteriabel.textColor = theme?.secondaryColor

        //
        if let activity = search.selected {
            categoryLabel.isHidden = false
            criteriabel.text = activity.title.label
            categoryLabel.text = activity.workplace.name
            addressLabel.text = activity.workplace.address.longLabel
            timeLabel.text = "3 days ago"
        } else {
            categoryLabel.isHidden = true
            criteriabel.text = search.criteria
            addressLabel.text = search.address
            timeLabel.text = "3 days ago"
        }
    }
    
    @IBAction func onRemoveAction(_ sender: Any) {
        if let indexPath = indexPath {
            delegate?.shouldRemoveSearchAt(indexPath: indexPath)
        }
    }
    
}
