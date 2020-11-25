//
//  OKIconTitleConfigure.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation
import UIKit

public struct OKIconTitleConfigure {
    let image: UIImage!
    let titleText: String!
    let descriptionText: String!
    
    public init(image: UIImage!,
                titleText: String!,
                descriptionText: String!) {
        self.image = image
        self.titleText = titleText
        self.descriptionText = descriptionText
    }
}
