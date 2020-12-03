//
//  HeaderViewMoreTableViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit

protocol HeaderViewMoreTableViewCellDelegate: class {
    func onAction(indexPath: IndexPath)
}

class HeaderViewMoreTableViewCell: UITableViewCell {
    private var indexPath: IndexPath!
    
    @IBOutlet weak var wrapperView: OKBaseView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    weak var delegate: HeaderViewMoreTableViewCellDelegate?
    
    func configWith(theme: OKThemeConfigure?, indexPath: IndexPath, title: String?, actionTitle: String?) {
        self.indexPath = indexPath
        wrapperView.borderColor = theme?.cardBorderColor ?? .lightGray
        headerTitleLabel.font = theme?.title2Font
        headerTitleLabel.text = title
        actionButton.setTitle(actionTitle, for: .normal)
        actionButton.setTitleColor(theme?.primaryColor, for: .normal)
        actionButton.titleLabel?.font = theme?.defaultFont
    }
    
    @IBAction func onAction(_ sender: Any) {
        delegate?.onAction(indexPath: indexPath)
    }
    
}
