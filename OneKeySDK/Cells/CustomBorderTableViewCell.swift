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
    
    func config(isLastRow: Bool) {
        if isLastRow {
            borderViewBottomContraint.constant = 0
        } else {
            borderViewBottomContraint.constant = -8
        }
    }
}
