//
//  MenuSection.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/13/20.
//

import Foundation

struct MenuSection {
    let title: String?
    let menus: [Menu]
    let colapsedLimit: Int?
    
    init(title: String? = nil, menus: [Menu], colapsedLimit: Int? = nil) {
        self.title = title
        self.menus = menus
        self.colapsedLimit = colapsedLimit
    }
}
