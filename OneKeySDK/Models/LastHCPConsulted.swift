//
//  LastHCPConsulted.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/29/20.
//

import Foundation

struct LastHCPConsulted: Codable {
    let timeInterval: Double!
    let activity: Activity!
}

extension LastHCPConsulted: Equatable {
    static func == (lhs: LastHCPConsulted, rhs: LastHCPConsulted) -> Bool {
        return lhs.activity.id == rhs.activity.id
    }
}
