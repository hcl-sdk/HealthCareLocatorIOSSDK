//
//  CustomFontViewController.swift
//  OneKeySDKDemo
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
    private let allFontNames = UIFont.allFontNames
    
    var selectedMenu: Menu?
    
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var showcaseLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    
    weak var delegate: CustomThemeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for fontName in UIFont.familyNames {
            print(UIFont.fontNames(forFamilyName: fontName).joined(separator: "\n"))
        }
        
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
    
}

extension CustomFontViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFontNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontFamilyTableViewCell") as! FontFamilyTableViewCell
        let font = UIFont(name: allFontNames[indexPath.row], size: 17.0)!
        let isUsingFont = allFontNames[indexPath.row] == showcaseLabel.font.fontName
        cell.configWith(font: font, selected: isUsingFont)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configFont.set(name: allFontNames[indexPath.row])
        tableView.reloadData()
    }
}
