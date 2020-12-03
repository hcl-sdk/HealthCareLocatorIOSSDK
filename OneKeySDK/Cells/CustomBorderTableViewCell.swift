//
//  CustomBorderTableViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit

class CustomBorderTableViewCell: UITableViewCell, OKIndexAble {
    var indexPath: IndexPath?
    
    @IBOutlet weak var topSeperatorLine: UIView!
    @IBOutlet weak var borderView: OKBaseView!
    @IBOutlet weak var borderViewTopContraint: NSLayoutConstraint!
    @IBOutlet weak var borderViewBottomContraint: NSLayoutConstraint!
    
    func config(theme: OKThemeConfigure?, isLastRow: Bool) {
        topSeperatorLine.backgroundColor = theme?.cardBorderColor ?? .lightGray
        borderView.borderColor = theme?.cardBorderColor ?? .lightGray
        
        if isLastRow {
            borderViewBottomContraint.constant = 0
        } else {
            borderViewBottomContraint.constant = -8
        }
    }
}
