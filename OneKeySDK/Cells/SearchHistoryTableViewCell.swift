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
    @IBOutlet weak var closeButton: UIButton!
    
    weak var delegate: OKSearchHistoryCellDelegate?

    func configWith(theme: OKThemeConfigure?, lang: String, search: OKHCPLastSearch, isLastRow: Bool) {
        super.config(theme: theme, isLastRow: isLastRow)
        // Fonts
        criteriabel.font = theme?.defaultFont
        addressLabel.font = theme?.defaultFont
        timeLabel.font = theme?.smallFont
        
        // Colors
        closeButton.tintColor = theme?.greyDarkColor
        criteriabel.textColor = theme?.secondaryColor
        timeLabel.textColor = theme?.darkColor
        addressLabel.textColor = theme?.greyDarkColor

        //
        criteriabel.text = search.search.code?.longLbl ?? search.search.criteria
        addressLabel.text = (search.search.isNearMeSearch == true || search.search.isQuickNearMeSearch == true) ? kNearMeTitle : search.search.address
        timeLabel.text = String(format: "%@ ago", Date(timeIntervalSince1970: search.timeInterval).timeAgo(locale: lang))
    }
    
    @IBAction func onRemoveAction(_ sender: Any) {
        if let indexPath = indexPath {
            delegate?.shouldRemoveSearchAt(indexPath: indexPath)
        }
    }
    
}
