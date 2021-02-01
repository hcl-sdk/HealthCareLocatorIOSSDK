//
//  DefaultThemesViewController.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/27/20.
//

import UIKit

class DefaultThemesViewController: UIViewController {
    var menus: [MenuSection] = []
    
    weak var delegate: MenuTableViewControllerDelegate?
    var menuTable: MenuTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    func reloadData() {
        let selectedTheme = AppSettings.selectedTheme
        let isGreenThemeSelected = selectedTheme == Theme.defaultGreenTheme
        let isBlueThemeSelected = selectedTheme == Theme.defaultBlueTheme
        let isRedThemeSelected = selectedTheme == Theme.defaultRedTheme
        let isPurpleThemeSelected = selectedTheme == Theme.defaultPurpleTheme
        
        let isCustomThemeSelected = !isGreenThemeSelected && !isBlueThemeSelected && !isRedThemeSelected && !isPurpleThemeSelected
        
        var themeMenus = [Menu.selectMenu(title: kMenuGreenThemeTitle, selected: isGreenThemeSelected, data: Theme.defaultGreenTheme),
                          Menu.selectMenu(title: kMenuBlueThemeTitle, selected: isBlueThemeSelected, data: Theme.defaultBlueTheme),
                          Menu.selectMenu(title: kMenuRedThemeTitle, selected: isRedThemeSelected, data: Theme.defaultRedTheme),
                          Menu.selectMenu(title: kMenuPurpleThemeTitle, selected: isPurpleThemeSelected, data: Theme.defaultPurpleTheme)]
        
        if isCustomThemeSelected {
            themeMenus.append(Menu.selectMenu(title: kMenuCustomThemeTitle, selected: true, data: AppSettings.selectedTheme))
        }
        
        menus = [MenuSection(title: kMenuThemeTitle,
                             menus: themeMenus)]
        
        menuTable.reloadData(menus: menus)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "embedMenuTable":
                if let menuVC = segue.destination as? MenuTableViewController {
                    menuVC.delegate = self
                    menuVC.menus = menus
                    menuTable = menuVC
                }
            default:
                return
            }
        }
    }

}

extension DefaultThemesViewController: MenuTableViewControllerDelegate {
    func didSelect(menu: Menu) {
        delegate?.didSelect(menu: menu)
        navigationController?.popViewController(animated: true)
    }
}
