//
//  FontMenuTableViewCell.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/16/20.
//

import UIKit

class FontMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var showcaseLabel: UILabel!
    
    func configWith(title: String, font: UIFont) {
        menuTitleLabel.text = title
        showcaseLabel.font = font
        showcaseLabel.text = "Preview"
    }
}
