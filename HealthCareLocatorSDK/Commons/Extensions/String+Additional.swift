//
//  String+Additional.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/23/20.
//

import Foundation

extension String {
    
    var localized: String {
        return localized(lang: HCLManager.shared.lang.code)
    }
    
    func localized(lang: String) -> String {
        if let path = Bundle.internalBundle().path(forResource: String(lang), ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: kLocalizedTableName, bundle: bundle, value: "", comment: "")
        } else {
            return self
        }
    }
}
