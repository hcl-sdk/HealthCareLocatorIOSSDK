//
//  ViewDesign.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation

protocol ViewDesign {
    func layoutWith(theme: OKThemeConfigure)
    func layoutWith(theme: OKThemeConfigure, icons: OKIconsConfigure)
}

extension ViewDesign {
    var theme: OKThemeConfigure {
        return OKManager.shared.themConfigure ?? OKThemeConfigure()
    }
    
    var icons: OKIconsConfigure {
        return OKManager.shared.iconsConfigure ?? OKIconsConfigure()
    }
    
    func layoutWith(theme: OKThemeConfigure) {}
    func layoutWith(theme: OKThemeConfigure, icons: OKIconsConfigure) {}
}
