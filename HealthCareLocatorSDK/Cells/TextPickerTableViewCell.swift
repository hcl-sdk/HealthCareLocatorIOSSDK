//
//  TextPickerTableViewCell.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/27/20.
//

import UIKit

class TextPickerTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    
    func configWith(theme: HCLThemeConfigure?, item: String, selected: Bool) {
        backgroundColor = theme?.darkmode ?? false ? kDarkLightColor : .white
        itemLabel.font = theme?.defaultFont
        itemLabel.text = item
        itemLabel.textColor = theme?.darkmode ?? false ? .white : theme?.darkColor
        tintColor = theme?.secondaryColor
        accessoryType = selected ? .checkmark : .none
    }
    
}
