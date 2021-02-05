//
//  HCLManagerProtocol.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/5/20.
//

import Foundation

protocol  HCLSDKConfigure {
    var searchNavigationController: HCLHCPSearchNavigationViewController? { get }
    var userId: String? { get }
    var appName: String? { get }
    var appDownloadLink: String? { get }
    var searchConfigure: HCLSearchConfigure? { get }
    var themConfigure: HCLThemeConfigure? { get }
    var iconsConfigure: HCLIconsConfigure? { get }
    var lang: HCLLanguage! { get }
}

protocol HCLManagerProtocol {
    func initialize(apiKey: String, configure: HCLSearchConfigure?,
                    theme: HCLThemeConfigure?,
                    icons: HCLIconsConfigure?,
                    handler: ((Bool, Error?) -> Void)?)
    func set(userId: String)
    func set(appName: String, appDownloadLink: String?)
    func configure(search: HCLSearchConfigure?)
    func configure(theme: HCLThemeConfigure?)
    func configure(icons: HCLIconsConfigure?)
    func getDefaultSearchConfigure() -> HCLSearchConfigure
    func getDefaultUIConfigure() -> HCLThemeConfigure
    func getHCPSearchViewController() -> HCLHCPSearchNavigationViewController
    func searchNearMe(specialities: [String]) -> Bool
    func setLocale(language: HCLLanguage)
}
