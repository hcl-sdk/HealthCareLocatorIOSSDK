//
//  ColorPickerWrapperViewController.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/12/20.
//

import UIKit
import FlexColorPicker

class ColorPickerWrapperViewController: UIViewController {
    
    var selectedMenu: Menu?
    @IBOutlet weak var topLabel: UILabel!
    
    
    var colorPickerVC: DefaultColorPickerViewController!
    weak var delegate: CustomThemeDelegate?
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var rTextField: UITextField!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var gTextField: UITextField!
    @IBOutlet weak var bSlider: UISlider!
    @IBOutlet weak var bTextField: UITextField!
    @IBOutlet weak var hexCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rTextField.delegate = self
        gTextField.delegate = self
        bTextField.delegate = self
        hexCodeTextField.delegate = self
        
        if let menu = selectedMenu {
            switch menu {
            case .colorMenu(let title, _):
                topLabel.text = title
            default:
                break
            }
        }
    }
    
    private func layoutWith(color: UIColor) {
        colorPickerVC.selectedColor = color
        var redVal:CGFloat = 0
        var greenVal:CGFloat = 0
        var blueVal:CGFloat = 0
        color.getRed(&redVal, green: &greenVal, blue: &blueVal, alpha: nil)
        rTextField.text = "\(Int(255*redVal))"
        gTextField.text = "\(Int(255*greenVal))"
        bTextField.text = "\(Int(255*blueVal))"
        rSlider.value = Float(redVal*255)
        gSlider.value = Float(greenVal*255)
        bSlider.value = Float(blueVal*255)
        hexCodeTextField.text = color.hexValue()
        delegate?.didSelect(color: color, for: selectedMenu!)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let redVal = rSlider.value
        let greenVal = gSlider.value
        let blueVal = bSlider.value
        rTextField.text = "\(Int(redVal))"
        gTextField.text = "\(Int(greenVal))"
        bTextField.text = "\(Int(blueVal))"
        let color = UIColor(red: CGFloat(redVal/255), green: CGFloat(greenVal/255), blue: CGFloat(blueVal/255), alpha: 1)
        hexCodeTextField.text = color.hexValue()
        colorPickerVC.selectedColor = color
        delegate?.didSelect(color: color, for: selectedMenu!)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "embedColorPicker":
                if let colorPicker = segue.destination as? DefaultColorPickerViewController {
                    colorPicker.delegate = self
                    self.colorPickerVC = colorPicker
                    if let menu = selectedMenu {
                        switch menu {
                        case .colorMenu(_, let color):
                            layoutWith(color: color)
                        default:
                            break
                        }
                    }
                }
            default:
                return
            }
        }
    }
    
}

extension ColorPickerWrapperViewController: ColorPickerDelegate {
    func colorPicker(_ colorPicker: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
        layoutWith(color: selectedColor)
    }
    
    func colorPicker(_ colorPicker: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {
    }
}

extension ColorPickerWrapperViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let newText = text.replacingCharacters(in: textRange, with: string)
            switch textField {
            case hexCodeTextField:
                return newText.count <= 6
            case rTextField, gTextField, bTextField:
                let val = Int(newText) ?? 0
                return val <= 255 && val >= 0
            default:
                return true
            }
            
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case hexCodeTextField:
            if let code = textField.text {
                let color = UIColor(hexString: code)
                layoutWith(color: color)
            } else {
                let color = colorPickerVC.selectedColor
                layoutWith(color: color)
            }
        case rTextField, gTextField, bTextField:
            if let r = rTextField.text,
               let g = gTextField.text,
               let b = bTextField.text {
                let rVal = CGFloat(Int(r) ?? 0)
                let gVal = CGFloat(Int(g) ?? 0)
                let bVal = CGFloat(Int(b) ?? 0)
                let color = UIColor(red: rVal/255, green: gVal/255, blue: bVal/255, alpha: 1)
                layoutWith(color: color)
            } else {
                let color = colorPickerVC.selectedColor
                layoutWith(color: color)
            }
        default:
            return
        }
    }
}
