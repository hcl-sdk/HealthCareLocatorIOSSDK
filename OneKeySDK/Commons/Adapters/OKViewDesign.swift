//
//  OKViewDesign.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation

protocol OKViewDesign {
    var theme: OKThemeConfigure? { get set }
    func config(theme: OKThemeConfigure)
}
