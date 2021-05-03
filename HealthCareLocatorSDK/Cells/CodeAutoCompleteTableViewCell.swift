//
//  CodeAutoCompleteTableViewCell.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/15/20.
//

import UIKit

class CodeAutoCompleteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    func configWith(theme: HCLThemeConfigure, code: Code, highlight: String?) {
        separatorView.backgroundColor = theme.greyLighterColor
        codeLabel.font = theme.defaultFont
        codeLabel.textColor = theme.darkColor
        guard let longLabel = code.longLbl else {return}
        let attibuteText = NSMutableAttributedString(string: longLabel)
        if let highlightText = highlight {
            let range = NSString(string: attibuteText.mutableString.lowercased).range(of: highlightText.lowercased())
            attibuteText.addAttribute(NSAttributedString.Key.foregroundColor, value: theme.primaryColor as Any, range: range)
        }
        codeLabel.attributedText = attibuteText
    }
    
}
