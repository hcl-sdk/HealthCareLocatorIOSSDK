//
//  HeaderViewMoreTableViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit

class HeaderViewMoreTableViewCell: UITableViewCell {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    func configWith(theme: OKThemeConfigure?, title: String?, actionTitle: String?) {
        headerTitleLabel.font = theme?.titleFont
        headerTitleLabel.text = title
        actionButton.setTitle(actionTitle, for: .normal)
        actionButton.setTitleColor(theme?.primaryColor, for: .normal)
        actionButton.titleLabel?.font = theme?.defaultFont
    }
    
}
