//
//  FontFamilyTableViewCell.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/16/20.
//

import UIKit

class FontFamilyTableViewCell: UITableViewCell {
    @IBOutlet weak var fontFamilyLabel: UILabel!
    @IBOutlet weak var selectIcon: UIImageView!
    
    func configWith(font: UIFont, selected: Bool) {
        fontFamilyLabel.text = font.fontName
        fontFamilyLabel.font = font
        selectIcon.alpha = selected ? 1 : 0
    }
}
