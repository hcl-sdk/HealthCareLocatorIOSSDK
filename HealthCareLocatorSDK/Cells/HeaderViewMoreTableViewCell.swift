//
//  HeaderViewMoreTableViewCell.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit

protocol HeaderViewMoreTableViewCellDelegate: class {
    func onAction(indexPath: IndexPath)
}

class HeaderViewMoreTableViewCell: UITableViewCell {
    private var indexPath: IndexPath!
    
    @IBOutlet weak var wrapperView: BaseView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    weak var delegate: HeaderViewMoreTableViewCellDelegate?
    
    func configWith(theme: HCLThemeConfigure?, indexPath: IndexPath, title: String?, actionTitle: String?) {
        self.indexPath = indexPath
        wrapperView.borderColor = theme?.cardBorderColor ?? .lightGray
        headerTitleLabel.textColor = theme?.darkColor
        headerTitleLabel.font = theme?.cardTitleFont
        headerTitleLabel.text = title
        if let action = actionTitle {
            
            actionButton.isHidden = false
            actionButton.setTitle(action, for: .normal)
            actionButton.setTitleColor(theme?.primaryColor, for: .normal)
            actionButton.titleLabel?.font = theme?.smallFont
        } else {
            actionButton.isHidden = true
        }
        
    }
    
    @IBAction func onAction(_ sender: Any) {
        delegate?.onAction(indexPath: indexPath)
    }
    
}
