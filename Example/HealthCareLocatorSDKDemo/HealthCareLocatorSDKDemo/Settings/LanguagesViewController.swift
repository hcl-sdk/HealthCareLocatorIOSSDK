//
//  LanguagesViewController.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 12/23/20.
//

import UIKit

class LanguagesViewController: UIViewController {

    var menuTable: MenuTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.reloadData(menus: menus())
    }
    
    func menus() -> [MenuSection] {
        let selectedLang = AppSettings.language
        let languageMenus = Language.allCases.map {Menu.selectMenu(title: $0.title,
                                                                   selected: $0.rawValue == selectedLang,
                                                                   data: $0)}
        return [MenuSection(title: kMenuLanguageTitle, menus: languageMenus, colapsedLimit: nil)]
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "embedMenuTable":
                if let menuVC = segue.destination as? MenuTableViewController {
                    menuVC.delegate = self
                    menuTable = menuVC
                }
            default:
                return
            }
        }
    }

}

extension LanguagesViewController: MenuTableViewControllerDelegate {
    func didSelect(menu: Menu) {
        switch menu {
        case .selectMenu(_, _, let lang):
            if let language = lang as? Language {
                AppSettings.language = language.rawValue
            }
            menuTable.reloadData(menus: menus())
        default:
            return
        }
    }
}
