//
//  CustomThemeDelegate.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/16/20.
//

import Foundation
import UIKit

protocol CustomThemeDelegate: class {
    func didSelect(color: UIColor, for menu: Menu)
    func didSelect(font: UIFont, for menu: Menu)
}
