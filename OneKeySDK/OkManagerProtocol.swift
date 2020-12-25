//
//  OkManagerProtocol.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/5/20.
//

import Foundation

protocol OkManagerProtocol {
    func initialize(apiKey: String, configure: OKSearchConfigure?, handler: ((Bool, Error?) -> Void)?)
    func set(userId: String)
    func configure(search: OKSearchConfigure)
    func getDefaultSearchConfigure() -> OKSearchConfigure
    func getDefaultUIConfigure() -> OKThemeConfigure
    func getHCPSearchViewController(fullMode: Bool) -> OKHCPSearchNavigationViewController
    func searchNearMe(specialities: [String])
    func setLocale(lang: String)
}
