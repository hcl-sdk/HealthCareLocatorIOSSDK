//
//  CustomThemeViewController.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/13/20.
//

import UIKit

class CustomThemeViewController: UIViewController {
    
    var selectedTheme = AppSettings.selectedTheme
    
    private var menuVC: MenuTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadDataWith(theme: selectedTheme)
    }
    
    private func reloadDataWith(theme: Theme) {
        var fontMenus: [Menu] = []
        var colorMenus: [Menu] = []
        let mirror = Mirror(reflecting: theme)
        for child in mirror.children {
            if let fontInfo = child.value as? FontInfo {
                fontMenus.append(Menu.fontMenu(title: child.label ?? "Unknow", font: UIFont.from(core: fontInfo)))
            } else if let colorCode = child.value as? String {
                colorMenus.append(Menu.colorMenu(title: child.label ?? "Unknow", color: UIColor(hexString: colorCode)))
            }
        }
        
        menuVC.reloadData(menus: [MenuSection(title: kMenuCustomThemeFontsTitle, menus: fontMenus, colapsedLimit: 5),
                                  MenuSection(title: kMenuCustomThemeColorsTitle, menus: colorMenus, colapsedLimit: 5)])

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func backAction(_ sender: Any) {
        if selectedTheme == AppSettings.selectedTheme {
            performSegue(withIdentifier: "backToSettingVC", sender: nil)
        } else {
            let okAction = UIAlertAction(title: "Ok", style: .default) {[unowned self] (_) in
                self.performSegue(withIdentifier: "backToSettingVC", sender: nil)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) {[unowned self] (_) in
                self.dismiss(animated: true, completion: nil)
            }
            
            let alertVC = UIAlertController(title: "WARNING", message: "Do you want to discard your changes?", preferredStyle: .alert)
            alertVC.addAction(okAction)
            alertVC.addAction(cancelAction)
            present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func applyCustomConfig(_ sender: Any) {
        AppSettings.selectedTheme = selectedTheme
        performSegue(withIdentifier: "backToSettingVC", sender: selectedTheme)
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToCustomThemeViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "EmbedMenuTableView":
                if let menuVC = segue.destination as? MenuTableViewController {
                    self.menuVC = menuVC
                    menuVC.delegate = self
                }
            case "showColorPickerVC":
                if let colorPickerVC = segue.destination as? ColorPickerWrapperViewController,
                   let menu = sender as? Menu {
                    colorPickerVC.selectedMenu = menu
                    colorPickerVC.delegate = self
                }
            case "showCustomFontVC":
                if let customFontVC = segue.destination as? CustomFontViewController,
                   let menu = sender as? Menu {
                    customFontVC.selectedMenu = menu
                    customFontVC.delegate = self
                }
            default:
                return
            }
        }
    }
    
}

extension CustomThemeViewController: MenuTableViewControllerDelegate {
    func didSelect(menu: Menu) {
        switch menu {
        case .colorMenu:
            performSegue(withIdentifier: "showColorPickerVC", sender: menu)
        case .fontMenu:
            performSegue(withIdentifier: "showCustomFontVC", sender: menu)
        default:
            return
        }
    }
}

extension CustomThemeViewController: CustomThemeDelegate {
    func didSelect(font: UIFont, for menu: Menu) {
        switch menu {
        case .fontMenu(let title, _):
            if let newTheme = selectedTheme.set(value: font.core.json, for: title) {
                selectedTheme = newTheme
            }
        default:
            return
        }
        reloadDataWith(theme: selectedTheme)
    }
    
    func didSelect(color: UIColor, for menu: Menu) {
        switch menu {
        case .colorMenu(let title, _):
            if let newTheme = selectedTheme.set(value: color.hexValue(), for: title) {
                selectedTheme = newTheme
            }
        default:
            return
        }
        reloadDataWith(theme: selectedTheme)
    }
}
