//
//  TextMenuTableViewCell.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/12/20.
//

import UIKit

class TextMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var menuValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func config(title: String, value: String?) {
        menuTitleLabel.text = title
        menuValueLabel.text = value
        menuValueLabel.isHidden = value == nil
    }
}
