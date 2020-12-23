//
//  String+Additional.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/23/20.
//

import Foundation

extension String {
    func localized(lang: String) -> String {
        if let path = Bundle.internalBundle().path(forResource: lang, ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: kLocalizedTableName, bundle: bundle, value: "", comment: "")
        } else {
            return self
        }
    }
}
