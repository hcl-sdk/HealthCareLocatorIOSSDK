//
//  SettingsViewController.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/12/20.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var menus: [MenuSection] = []
    
    var menuVC: MenuTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadSettings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    private func reloadSettings() {
        let selectedTheme = AppSettings.selectedTheme
        
        let isGreenThemeSelected = selectedTheme == Theme.defaultGreenTheme
        let isBlueThemeSelected = selectedTheme == Theme.defaultBlueTheme
        let isRedThemeSelected = selectedTheme == Theme.defaultRedTheme
        let isPurpleThemeSelected = selectedTheme == Theme.defaultPurpleTheme

        let isCustomThemeSelected = !isGreenThemeSelected && !isBlueThemeSelected && !isRedThemeSelected && !isPurpleThemeSelected
        
        var themeSection: MenuSection!

        let apiSection = MenuSection(title: kMenuAPIKeyTitle,
                                     menus: [Menu.inputMenu(placeHolder: kMenuAPIKeyTitle, value: AppSettings.APIKey)])
        
        let language = Language(rawValue: AppSettings.language) ?? .english
        let languageSection = MenuSection(title: kMenuLanguageTitle,
                                          menus: [Menu.detailMenu(title: language.title)], colapsedLimit: nil)
        
        let editHCPSection = MenuSection(title: kMenuSuggestEditHCPEnabledTitle,
                                         menus: [Menu.toggleMenu(title: kMenuEnableEditHCPTitle, isOn: AppSettings.isSuggestEditHCPEnabled)],
                                         colapsedLimit: nil)
        
        var themeMenus = [Menu.textMenu(title: kMenuEditThemeTitle, value: nil)]
        
        if isCustomThemeSelected {
            themeMenus.insert(Menu.detailMenu(title: kMenuCustomThemeTitle), at: 0)
        } else {
            switch selectedTheme {
            case Theme.defaultGreenTheme:
                themeMenus.insert(Menu.detailMenu(title: kMenuGreenThemeTitle), at: 0)
            case Theme.defaultBlueTheme:
                themeMenus.insert(Menu.detailMenu(title: kMenuBlueThemeTitle), at: 0)
            case Theme.defaultRedTheme:
                themeMenus.insert(Menu.detailMenu(title: kMenuRedThemeTitle), at: 0)
            case Theme.defaultPurpleTheme:
                themeMenus.insert(Menu.detailMenu(title: kMenuPurpleThemeTitle), at: 0)
            default:
                break
            }
        }
        
        themeSection = MenuSection(title: kMenuThemeTitle,
                                   menus: themeMenus)
        
        menus = [apiSection,
                 languageSection,
                 editHCPSection,
                 themeSection]
        menuVC.reloadData(menus: menus)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    @IBAction func unwindToSettingsViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "EmbedMenuTableView":
                if let menuVC = segue.destination as? MenuTableViewController {
                    self.menuVC = menuVC
                    menuVC.delegate = self
                    menuVC.menus = menus
                }
            case "showDefaultThemeList":
                if let defaultThemesVC = segue.destination as? DefaultThemesViewController {
                    defaultThemesVC.delegate = self
                }
            default:
                return
            }
        }
    }
    
}

extension SettingsViewController: MenuTableViewControllerDelegate {
    func didSelect(menu: Menu) {
        switch menu {
        case .selectMenu(_, _, let data):
            if let theme = data as? Theme {
                applySelected(theme: theme)
            }
        case .detailMenu(let title):
            switch title {
            case kMenuGreenThemeTitle,
                 kMenuBlueThemeTitle,
                 kMenuRedThemeTitle,
                 kMenuPurpleThemeTitle,
                 kMenuCustomThemeTitle:
                performSegue(withIdentifier: "showDefaultThemeList", sender: nil)
            case Language.english.title,
                 Language.french.title:
                performSegue(withIdentifier: "showLanguageList", sender: nil)
            default:
                break
            }
        case .textMenu(let title, _):
            switch title {
            case kMenuEditThemeTitle:
                performSegue(withIdentifier: "showCustomThemeVC", sender: nil)
            default:
                break
            }
        default:
            return
        }
    }
    
    func didChangeValueFor(menu: Menu, newValue: Any?) {
        switch menu {
        case .toggleMenu(let title, _):
            switch title {
            case kMenuEnableEditHCPTitle:
                AppSettings.isSuggestEditHCPEnabled = (newValue as? Bool) == true
            default:
                break
            }
        case .inputMenu(let title, _):
            switch title {
            case kMenuAPIKeyTitle:
                AppSettings.APIKey = (newValue as? String) ?? ""
            default:
                break
            }
        default:
            break
        }
    }
    
    private func applySelected(theme: Theme) {
        AppSettings.selectedTheme = theme
        reloadSettings()
    }
}
