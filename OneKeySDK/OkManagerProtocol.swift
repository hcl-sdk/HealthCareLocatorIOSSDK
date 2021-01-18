//
//  OkManagerProtocol.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/5/20.
//

import Foundation

protocol  OKSDKConfigure {
    var searchNavigationController: OKHCPSearchNavigationViewController? { get }
    var userId: String? { get }
    var appName: String? { get }
    var appDownloadLink: String? { get }
    var searchConfigure: OKSearchConfigure? { get }
    var themConfigure: OKThemeConfigure? { get }
    var iconsConfigure: OKIconsConfigure? { get }
    var lang: String! { get }
}

protocol OkManagerProtocol {
    func initialize(apiKey: String, configure: OKSearchConfigure?,
                    theme: OKThemeConfigure?,
                    icons: OKIconsConfigure?,
                    handler: ((Bool, Error?) -> Void)?)
    func set(userId: String)
    func set(appName: String, appDownloadLink: String?)
    func configure(search: OKSearchConfigure?)
    func configure(theme: OKThemeConfigure?)
    func configure(icons: OKIconsConfigure?)
    func getDefaultSearchConfigure() -> OKSearchConfigure
    func getDefaultUIConfigure() -> OKThemeConfigure
    func getHCPSearchViewController() -> OKHCPSearchNavigationViewController
    func searchNearMe(specialities: [String]) -> Bool
    func setLocale(lang: String)
}
