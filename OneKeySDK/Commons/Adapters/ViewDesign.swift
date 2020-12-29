//
//  ViewDesign.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation

protocol ViewDesign {
    var theme: OKThemeConfigure? { get set }
    func layoutWith(theme: OKThemeConfigure)
}

extension ViewDesign {
    func layoutWith(theme: OKThemeConfigure) {}
}
