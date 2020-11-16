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
        let defaultFont = UIFont(name: theme.defaultFontName, size: theme.defaultFontSize)!
        let titleFont = UIFont(name: theme.titleFontName, size: theme.titleFontSize)!
        let fontsSectionMenus = MenuSection(title: kMenuCustomThemeFontsTitle,
                                            menus: [Menu.fontMenu(title: kMenuCustomThemeFontsDefaultTitle,
                                                                  font: defaultFont),
                                                    Menu.fontMenu(title: kMenuCustomThemeFontsTitleTitle,
                                                                          font: titleFont)])
        
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
        var defaultFontName = selectedTheme.defaultFontName
        var titleFontName = selectedTheme.titleFontName
        var titleFontSize = selectedTheme.titleFontSize
        var defaultFontSize = selectedTheme.defaultFontSize
        
        switch menu {
        case .fontMenu(let title, _):
            switch title {
            case kMenuCustomThemeFontsDefaultTitle:
                defaultFontName = font.fontName
                defaultFontSize = font.pointSize
            case kMenuCustomThemeFontsTitleTitle:
                titleFontName = font.fontName
                titleFontSize = font.pointSize
            default:
                break
            }
        default:
            return
        }
        
        selectedTheme = Theme(defaultFontName: defaultFontName,
                              defaultFontSize: defaultFontSize,
                              titleFontName: titleFontName,
                              titleFontSize: titleFontSize,
                              primaryColorHex: selectedTheme.primaryColorHex,
                              secondaryColorHex: selectedTheme.secondaryColorHex,
                              markerColorHex: selectedTheme.markerColorHex,
                              selectedMarkerColorHex: selectedTheme.selectedMarkerColorHex)
        reloadDataWith(theme: selectedTheme)
    }
    
    func didSelect(color: UIColor, for menu: Menu) {
        var primaryColorHex = selectedTheme.primaryColorHex
        var secondaryColorHex = selectedTheme.secondaryColorHex
        var markerColorHex = selectedTheme.markerColorHex
        var selectedMarkerColorHex = selectedTheme.selectedMarkerColorHex
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
        selectedTheme = Theme(defaultFontName: selectedTheme.defaultFontName,
                              defaultFontSize: selectedTheme.defaultFontSize,
                              titleFontName: selectedTheme.titleFontName,
                              titleFontSize: selectedTheme.titleFontSize,
                              primaryColorHex: primaryColorHex,
                              secondaryColorHex: secondaryColorHex,
                              markerColorHex: markerColorHex,
                              selectedMarkerColorHex: selectedMarkerColorHex)
        reloadDataWith(theme: selectedTheme)
    }
}
