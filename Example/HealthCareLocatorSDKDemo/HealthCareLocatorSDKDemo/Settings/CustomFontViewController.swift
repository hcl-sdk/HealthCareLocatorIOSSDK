//
//  CustomFontViewController.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/16/20.
//

import UIKit
import RxSwift
import RxCocoa

extension UIFont {
    static let allFontNames: [String] = UIFont.familyNames.map {UIFont.fontNames(forFamilyName: $0)}.reduce([]) { (result, next) -> [String] in
        var newResult = result
        newResult.append(contentsOf: next)
        return newResult
    }
}

class CustomFontViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let configFont = ConfigFont()

    var selectedMenu: Menu?
    
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var showcaseLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var fontFamilyTextField: UITextField!
    @IBOutlet weak var fontStyleTextField: UITextField!
    
    let pickerView = UIPickerView()
    var isEditingFontFamily: Bool = false {
        didSet {
            if isEditingFontFamily {
                isEditingFontStyle = false
            }
        }
    }
    
    var isEditingFontStyle: Bool = false {
        didSet {
            if isEditingFontStyle {
                isEditingFontFamily = false
            }
        }
    }
    
    weak var delegate: CustomThemeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for fontName in UIFont.familyNames {
            print(UIFont.fontNames(forFamilyName: fontName).joined(separator: "\n"))
        }
        
        pickerView.dataSource = self
        pickerView.delegate = self
        fontFamilyTextField.inputView = pickerView
        fontStyleTextField.inputView = pickerView

        if let menu = selectedMenu {
            setupBinding(menu: menu)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let font = configFont.getFont(), let menu = selectedMenu else {
            return
        }
        delegate?.didSelect(font: font, for: menu)
    }
    
    private func setupBinding(menu: Menu) {
        // Font - Size
        configFont.fontSizeAsString.bind(to: fontSizeLabel.rx.text).disposed(by: disposeBag)
        configFont.fontFamilyNameObservable.bind(to: fontFamilyTextField.rx.text).disposed(by: disposeBag)
        configFont.fontStyleAsStringObservable.bind(to: fontStyleTextField.rx.text).disposed(by: disposeBag)

        // Font - Showcase
        configFont.customFont.subscribe(onNext: { [weak self] font in
            self?.showcaseLabel.font = font
        }).disposed(by: disposeBag)
        
        switch menu {
        case .fontMenu(let title, let font):
            configFont.initializeWith(font: font)
            showcaseLabel.text = title
            navigationTitleLabel.text = "Customize \(title.uppercased()) Font"
        default:
            return
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func descreaseFontSizeAction(_ sender: Any) {
        if showcaseLabel.font.pointSize > 1 {
            configFont.set(size: showcaseLabel.font.pointSize - 1)
        }
    }
    
    @IBAction func increaseFontSizeAction(_ sender: Any) {
        configFont.set(size: showcaseLabel.font.pointSize + 1)
    }
    
    @IBAction func changeFontFamilyAction(_ sender: Any) {
    }
    
    @IBAction func changeFontStyleAction(_ sender: Any) {
    }
    
}

extension CustomFontViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return isEditingFontFamily ? FontMapping.allCases.count : FontStyles.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return isEditingFontFamily ? FontMapping.allCases[row].fontFamily : FontStyles.allCases[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isEditingFontFamily {
            let value = FontMapping.allCases[row]
            configFont.set(family: value)
        } else if isEditingFontStyle {
            let value = FontStyles.allCases[row]
            configFont.set(style: value)
        }
    }
}

extension CustomFontViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == fontFamilyTextField {
            isEditingFontFamily = true
        } else {
            isEditingFontStyle = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isEditingFontFamily = false
        isEditingFontStyle = false
    }
}
