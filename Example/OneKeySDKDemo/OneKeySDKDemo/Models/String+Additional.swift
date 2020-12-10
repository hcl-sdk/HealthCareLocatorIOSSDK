//
//  String+Additional.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 12/10/20.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
