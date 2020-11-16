//
//  SettingsViewController.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/12/20.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var menus: [MenuSection] = [Menu.APIKeyMenu,
                                Menu.themeMenus]
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
        let isGreenThemeSelected = AppSettings.selectedTheme == Theme.defaultGreenTheme
        let isBlueThemeSelected = AppSettings.selectedTheme == Theme.defaultBlueTheme
        let isRedThemeSelected = AppSettings.selectedTheme == Theme.defaultRedTheme
        let isCustomThemeSelected = !isGreenThemeSelected && !isBlueThemeSelected && !isRedThemeSelected
        
        menus = [Menu.APIKeyMenu,
                 MenuSection(title: kMenuThemeTitle,
                             menus: [Menu.selectMenu(title: kMenuGreenThemeTitle, selected: isGreenThemeSelected),
                                     Menu.selectMenu(title: kMenuBlueThemeTitle, selected: isBlueThemeSelected),
                                     Menu.selectMenu(title: kMenuRedThemeTitle, selected: isRedThemeSelected),
                                     Menu.selectMenu(title: kMenuCustomThemeTitle, selected: isCustomThemeSelected)])]
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
            default:
                return
            }
        }
    }
    
}

extension SettingsViewController: MenuTableViewControllerDelegate {
    func didSelect(menu: Menu) {
        switch menu {
        case .selectMenu(let title, _):
            switch title {
            case kMenuGreenThemeTitle:
                applySelected(theme: Theme.defaultGreenTheme)
            case kMenuBlueThemeTitle:
                applySelected(theme: Theme.defaultBlueTheme)
            case kMenuRedThemeTitle:
                applySelected(theme: Theme.defaultRedTheme)
            case kMenuCustomThemeTitle:
                performSegue(withIdentifier: "showCustomThemeVC", sender: nil)
            default:
                break
            }
            break
        default:
            return
        }
    }
    
    private func applySelected(theme: Theme) {
        AppSettings.selectedTheme = theme
        reloadSettings()
    }
}
