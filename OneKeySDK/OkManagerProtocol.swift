//
//  OkManagerProtocol.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/5/20.
//

import Foundation

protocol OKSDKConfigure {
    var searchNavigationController: OKHCPSearchNavigationViewController? { get }
    var apiKey: String? { get }
    var userId: String? { get }
    var searchConfigure: OKSearchConfigure? { get }
    var lang: String! { get }
}

protocol OkManagerProtocol {
    func initialize(apiKey: String, configure: OKSearchConfigure?, handler: ((Bool, Error?) -> Void)?)
    func set(userId: String)
    func configure(search: OKSearchConfigure)
    func getDefaultSearchConfigure() -> OKSearchConfigure
    func getDefaultUIConfigure() -> OKThemeConfigure
    func getHCPSearchViewController(fullMode: Bool) -> OKHCPSearchNavigationViewController
    func searchNearMe(specialities: [String]) -> Bool
    func setLocale(lang: String)
}
