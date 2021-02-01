//
//  ViewDesign.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation

protocol ViewDesign {
    func layoutWith(theme: HCLThemeConfigure)
    func layoutWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure)
}

extension ViewDesign {
    var theme: HCLThemeConfigure {
        return HCLManager.shared.themConfigure ?? HCLThemeConfigure()
    }
    
    var icons: HCLIconsConfigure {
        return HCLManager.shared.iconsConfigure ?? HCLIconsConfigure()
    }
    
    func layoutWith(theme: HCLThemeConfigure) {}
    func layoutWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {}
}
