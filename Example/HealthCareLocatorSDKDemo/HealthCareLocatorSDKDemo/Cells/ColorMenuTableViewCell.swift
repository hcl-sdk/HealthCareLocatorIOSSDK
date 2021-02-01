//
//  ColorMenuTableViewCell.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/12/20.
//

import UIKit

class ColorMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(title: String, color: UIColor) {
        menuTitleLabel.text = title
        colorView.backgroundColor = color
    }
}
