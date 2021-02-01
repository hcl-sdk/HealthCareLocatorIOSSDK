//
//  SelectMenuTableViewCell.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/13/20.
//

import UIKit

class SelectMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var selectedIcon: UIImageView!
    
    func configWith(title: String, selected: Bool) {
        menuTitleLabel.text = title
        selectedIcon.alpha = selected ? 1 : 0
    }

}
