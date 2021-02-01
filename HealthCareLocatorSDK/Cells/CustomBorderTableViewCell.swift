//
//  CustomBorderTableViewCell.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit

class CustomBorderTableViewCell: UITableViewCell, IndexAble {
    var indexPath: IndexPath?
    
    @IBOutlet weak var topseparatorLine: UIView!
    @IBOutlet weak var borderView: BaseView!
    @IBOutlet weak var borderViewTopContraint: NSLayoutConstraint!
    @IBOutlet weak var borderViewBottomContraint: NSLayoutConstraint!
    
    func config(theme: HCLThemeConfigure?, isLastRow: Bool) {
        topseparatorLine.backgroundColor = theme?.cardBorderColor ?? .lightGray
        borderView.borderColor = theme?.cardBorderColor ?? .lightGray
        
        if isLastRow {
            borderViewBottomContraint.constant = 0
        } else {
            borderViewBottomContraint.constant = -8
        }
    }
}
