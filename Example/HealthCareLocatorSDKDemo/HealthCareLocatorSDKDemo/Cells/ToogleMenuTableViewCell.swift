//
//  ToogleMenuTableViewCell.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/30/20.
//

import UIKit

class ToogleMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var toogleSwitch: UISwitch!
    var menu: Menu?
    weak var delegate: MenuTableViewControllerDelegate?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        toogleSwitch.layer.cornerRadius = 15.5
    }
    
    func configWith(menu: Menu) {
        self.menu = menu
        switch menu {
        case .toggleMenu(let title, let isOn):
            menuTitleLabel.text = title
            toogleSwitch.isOn = isOn
        default:
            return
        }
    }
    
    @IBAction func toogleValueAction(_ sender: UISwitch) {
        if let menu = self.menu, let delegate = self.delegate {
            delegate.didChangeValueFor(menu: menu, newValue: sender.isOn)
        }
    }
    
}
