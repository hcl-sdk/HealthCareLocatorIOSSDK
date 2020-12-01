//
//  OkManagerProtocol.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/5/20.
//

import Foundation

protocol OkManagerProtocol {
    func getDefaultUIConfigure() -> OKThemeConfigure
    func getHCPSearchViewController(fullMode: Bool) -> OKHCPSearchNavigationViewController
}
