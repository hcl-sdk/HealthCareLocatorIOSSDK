//
//  TextPickerTableViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/27/20.
//

import UIKit

class TextPickerTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    
    func configWith(theme: OKThemeConfigure?, item: String, selected: Bool) {
        itemLabel.font = theme?.defaultFont
        itemLabel.text = item
        tintColor = theme?.secondaryColor
        accessoryType = selected ? .checkmark : .none
    }
    
}
