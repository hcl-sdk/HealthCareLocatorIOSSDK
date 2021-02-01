//
//  DetailTableViewCell.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/13/20.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var menuTitleLabel: UILabel!
    
    func configWith(title: String) {
        menuTitleLabel.text = title
    }

}
