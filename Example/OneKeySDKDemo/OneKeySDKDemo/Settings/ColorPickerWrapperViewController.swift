//
//  ColorPickerWrapperViewController.swift
//  OneKeySDKDemo
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let menu = selectedMenu {
            switch menu {
            case .colorMenu(let title, _):
                topLabel.text = title
            default:
                break
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "embedColorPicker":
                if let colorPicker = segue.destination as? DefaultColorPickerViewController {
                    colorPicker.delegate = self
                    if let menu = selectedMenu {
                        switch menu {
                        case .colorMenu(_, let color):
                            colorPicker.selectedColor = color
                        default:
                            break
                        }
                    }
                    self.colorPickerVC = colorPicker
                }
            default:
                return
            }
        }
    }
    
}

extension ColorPickerWrapperViewController: ColorPickerDelegate {
    func colorPicker(_ colorPicker: ColorPickerController, selectedColor: UIColor, usingControl: ColorControl) {
        delegate?.didSelect(color: selectedColor, for: selectedMenu!)
    }
    
    func colorPicker(_ colorPicker: ColorPickerController, confirmedColor: UIColor, usingControl: ColorControl) {
    }
}
