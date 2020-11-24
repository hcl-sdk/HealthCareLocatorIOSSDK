//
//  Menu.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/13/20.
//

import Foundation
import UIKit

enum Menu {
    case textMenu(title: String, value: String?)
    case fontMenu(title: String, font: UIFont)
    case colorMenu(title: String, color: UIColor)
    case inputMenu(placeHolder: String, value: String?)
    case selectMenu(title: String, selected: Bool)
    case detailMenu(title: String)

    static let allMainMenus = [Menu.textMenu(title: kMenuNewSearchTitle, value: nil),
                               Menu.textMenu(title: kMenuSettingsTitle, value: nil)]
    static let APIKeyMenu = MenuSection(title: kMenuAPIKeyTitle,
                                        menus: [Menu.inputMenu(placeHolder: kMenuAPIKeyTitle, value: AppSettings.APIKey)])
    static let themeMenus = MenuSection(title: kMenuThemeTitle,
                                        menus: [Menu.selectMenu(title: kMenuGreenThemeTitle, selected: true),
                                                Menu.selectMenu(title: kMenuBlueThemeTitle, selected: false),
                                                Menu.selectMenu(title: kMenuRedThemeTitle, selected: false),
                                                Menu.selectMenu(title: kMenuCustomThemeTitle, selected: false)])
}
