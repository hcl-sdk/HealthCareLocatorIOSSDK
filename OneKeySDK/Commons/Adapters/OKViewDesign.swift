//
//  OKViewDesign.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation

protocol OKViewDesign {
    var theme: OKThemeConfigure? { get set }
    func layoutWith(theme: OKThemeConfigure)
}

extension OKViewDesign {
    func layoutWith(theme: OKThemeConfigure) {}
}
