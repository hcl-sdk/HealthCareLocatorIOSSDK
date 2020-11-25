//
//  OKHCPSearchConfigure.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import Foundation
import UIKit

public struct OKHCPSearchConfigure {
    let titleText: String?
    let HCPSearch: OKIconTitleConfigure?
    let consultSearch: OKIconTitleConfigure?
    let informationUpdate: OKIconTitleConfigure?
    
    public init(titleText: String?,
                HCPSearch: OKIconTitleConfigure?,
                consultSearch: OKIconTitleConfigure?,
                informationUpdate: OKIconTitleConfigure?) {
        self.titleText = titleText
        self.HCPSearch = HCPSearch
        self.consultSearch = consultSearch
        self.informationUpdate = informationUpdate
    }
}
