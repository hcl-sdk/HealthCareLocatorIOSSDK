//
//  UIFont+Additional.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 12/8/20.
//

import Foundation
import UIKit

struct FontInfo: Encodable, Decodable, Equatable {
    let fontName: String!
    let fontSize: CGFloat!
    
    var json: [String: Any] {
        if let data = (try? JSONEncoder().encode(self)) {
            return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]
        }
        return [:]
    }
}

extension UIFont {
    var core: FontInfo {
        return FontInfo(fontName: fontName, fontSize: pointSize)
    }
    
    static func from(core: FontInfo) -> UIFont {
        guard let font = UIFont(name: core.fontName, size: core.fontSize) else {
            fatalError("Invalid font name: \(String(describing: core.fontName))")
        }
        return font
    }
}
