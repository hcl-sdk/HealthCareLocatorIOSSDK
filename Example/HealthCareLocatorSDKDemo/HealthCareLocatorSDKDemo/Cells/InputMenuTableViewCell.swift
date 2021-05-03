//
//  InputMenuTableViewCell.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/13/20.
//

import UIKit

protocol InputMenuTableViewCellDelegate: class {
    func didChangeText(newText: String?, for cell: InputMenuTableViewCell)
}

class InputMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var inputTextField: UITextField!
    weak var delegate: InputMenuTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextField.delegate = self
    }
    
    func configWith(placeHolder: String, value: String?) {
        inputTextField.placeholder = placeHolder
        inputTextField.text = value
    }
}

extension InputMenuTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let newText = text.replacingCharacters(in: textRange, with: string)
            delegate?.didChangeText(newText: newText, for: self)
        } else {
            delegate?.didChangeText(newText: textField.text, for: self)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didChangeText(newText: textField.text, for: self)
    }
}
