//
//  SettingsViewController.swift
//  OneKeySDKDemo
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
        let homeModeSection = MenuSection(title: kMenuHomeTitle,
                                          menus: [Menu.toggleMenu(title: kSearchHomeFullTitle, isOn: AppSettings.fullHomeModeEnabled)])
        
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
        
        menus = [Menu.APIKeyMenu,
                 themeSection,
                 homeModeSection]
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
            case kSearchHomeFullTitle:
                if let newBool = newValue as? Bool {
                    AppSettings.fullHomeModeEnabled = newBool
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.reloadSettings()
                    }
                }
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
