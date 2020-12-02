//
//  CustomThemeViewController.swift
//  OneKeySDKDemo
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
        // Fonts
       let fontsSectionMenus = MenuSection(title: kMenuCustomThemeFontsTitle,
                                            menus: [Menu.fontMenu(title: kMenuCustomThemeFontsDefaultTitle,
                                                                  font: theme.defaultFont),
                                                    Menu.fontMenu(title: kMenuCustomThemeFontsTitle1Title,
                                                                  font: theme.title1Font),
                                                    Menu.fontMenu(title: kMenuCustomThemeFontsTitle2Title,
                                                                  font: theme.title2Font),
                                                    Menu.fontMenu(title: kMenuCustomThemeFontsTitle3Title,
                                                                  font: theme.title3Font),
                                                    Menu.fontMenu(title: kMenuCustomThemeFontsSearchInputTitle,
                                                                  font: theme.searchInputFont),
                                                    Menu.fontMenu(title: kMenuCustomThemeFontsButtonTitle,
                                                                  font: theme.buttonFont),
                                                    Menu.fontMenu(title: kMenuCustomThemeFontsSmallTitle,
                                                                  font: theme.smallFont)])
        
        // Colors
        let colorsSectionMenus = MenuSection(title: kMenuCustomThemeColorsTitle,
                                             menus: [Menu.colorMenu(title: kCustomThemePrimaryColorTitle,
                                                                    color: UIColor(hexString: theme.primaryColorHex)),
                                                     Menu.colorMenu(title: kCustomThemeSecondaryColorTitle,
                                                                    color: UIColor(hexString: theme.secondaryColorHex)),
                                                     Menu.colorMenu(title: kCustomThemeMarkerColorTitle,
                                                                    color: UIColor(hexString: theme.markerColorHex)),
                                                     Menu.colorMenu(title: kCustomThemeSelectedMarkerColorTitle,
                                                                    color: UIColor(hexString: theme.selectedMarkerColorHex))])
        menuVC.reloadData(menus: [fontsSectionMenus, colorsSectionMenus])
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
            if let theme = selectedTheme.change(font: font, for: title) {
                selectedTheme = theme
                reloadDataWith(theme: theme)
            }
        default:
            return
        }
    }
    
    func didSelect(color: UIColor, for menu: Menu) {
        var primaryColorHex = selectedTheme.primaryColorHex
        var secondaryColorHex = selectedTheme.secondaryColorHex
        var markerColorHex = selectedTheme.markerColorHex
        var selectedMarkerColorHex = selectedTheme.selectedMarkerColorHex
        var listBackgroundColorHex = selectedTheme.listBackgroundColorHex

        switch menu {
        case .colorMenu(let title, _):
            switch title {
            case kCustomThemePrimaryColorTitle:
                primaryColorHex = color.toHex()
            case kCustomThemeSecondaryColorTitle:
                secondaryColorHex = color.toHex()
            case kCustomThemeMarkerColorTitle:
                markerColorHex = color.toHex()
            case kCustomThemeSelectedMarkerColorTitle:
                selectedMarkerColorHex = color.toHex()
            default:
                break
            }
        default:
            return
        }
        selectedTheme = Theme(defaultFontName:  selectedTheme.defaultFontName,
                              defaultFontSize: selectedTheme.defaultFontSize,
                              title1FontName: selectedTheme.title1FontName,
                              title1FontSize: selectedTheme.title1FontSize,
                              title2FontName: selectedTheme.title2FontName,
                              title2FontSize: selectedTheme.title2FontSize,
                              title3FontName: selectedTheme.title3FontName,
                              title3FontSize: selectedTheme.title3FontSize,
                              searchInputFontName: selectedTheme.searchInputFontName,
                              searchInputFontSize: selectedTheme.searchInputFontSize,
                              buttonFontName: selectedTheme.buttonFontName,
                              buttonFontSize: selectedTheme.buttonFontSize,
                              smallFontName: selectedTheme.smallFontName,
                              smallFontSize: selectedTheme.smallFontSize,
                              primaryColorHex: primaryColorHex,
                              secondaryColorHex: secondaryColorHex,
                              markerColorHex: markerColorHex,
                              selectedMarkerColorHex: selectedMarkerColorHex,
                              listBackgroundColorHex: listBackgroundColorHex)
        reloadDataWith(theme: selectedTheme)
    }
}
