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
    case selectMenu(title: String, selected: Bool, data: Any?)
    case detailMenu(title: String)
    case toggleMenu(title: String, isOn: Bool)

    static let allMainMenus = [Menu.textMenu(title: kMenuHomeTitle, value: nil),
                               Menu.textMenu(title: kMenuNewSearchTitle, value: nil),
                               Menu.textMenu(title: kMenuNewNearMeSearchTitle, value: nil),
//                               Menu.textMenu(title: kMenuNewSearchFailedTitle, value: nil),
                               Menu.textMenu(title: kMenuSettingsTitle, value: nil)]
    
    static let preconfiguredSearchMenus = [Menu.textMenu(title: kMenuPreConfiguredNearMeSearch1Title, value: nil),
                                           Menu.textMenu(title: kMenuPreConfiguredNearMeSearch2Title, value: nil)]
    
    static let APIKeyMenu = MenuSection(title: kMenuAPIKeyTitle,
                                        menus: [Menu.inputMenu(placeHolder: kMenuAPIKeyTitle, value: AppSettings.APIKey)])
}
