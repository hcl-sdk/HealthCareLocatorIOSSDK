//
//  InputMenuTableViewCell.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/13/20.
//

import UIKit

class InputMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var inputTextField: UITextField!
    
    func configWith(placeHolder: String, value: String?) {
        inputTextField.placeholder = placeHolder
        inputTextField.text = value
    }
}
