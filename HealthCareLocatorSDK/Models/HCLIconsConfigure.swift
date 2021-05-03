//
//  HCLIconsConfigure.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 1/11/21.
//

import Foundation
import UIKit

/**
 The icons configuration object which can be used to customize icons for the screen of the seaching process
````
 let icons = HCLThemeConfigure(searchIcon: UIImage(named: "search-icon")!,
                              profileIcon: UIImage(named: "profile"),...
 let manager = HCLManager.shared
 manager.initialize(apiKey: <YOUR_API_KEY>, icons: icons)
 ````
 - Note:
 All of the properties of the icons configuration are optional, if the values is not set then a default value will be load to the UI
 - Important:
 Assign the icons configuration while init the **HCLManager** and before adding search screens into your app, If the icons configuration is not provided during initilization of **HCLManager**, a default icons set will be loaded into the UI
 
 Reference to the
 
 [document]: https://appnucleus.dvnet.com/onekey-sdk-help/index.htm#t=About_customizing_pre-built_search_screens.htm%23Home_screen_full_size_&rhsearch=ios&rhsyns=%20  "icons configuration"
 
 to get more detail how the icons will be used
 */

public struct HCLIconsConfigure {
    let searchIcon: UIImage!
    let profileIcon: UIImage!
    let editIcon: UIImage!
    let crossIcon: UIImage!
    let backIcon: UIImage!
    let geolocIcon: UIImage!
    let markerMinIcon: UIImage!
    let mapIcon: UIImage!
    let mapMarkerIcon: UIImage!
    let listIcon: UIImage!
    let sortIcon: UIImage!
    let arrowRightIcon: UIImage!
    let mapGeolocIcon: UIImage!
    let phoneIcon: UIImage!
    let faxIcon: UIImage!
    let websiteIcon: UIImage!
    let voteUpIcon: UIImage!
    let voteDownIcon: UIImage!
    let noResultsIcon: UIImage!

    public init(searchIcon: UIImage = UIImage.OKImageWith(name: "magnifier")!,
         profileIcon: UIImage = UIImage.OKImageWith(name: "profile")!,
         editIcon: UIImage = UIImage.OKImageWith(name: "edit")!,
         crossIcon: UIImage = UIImage.OKImageWith(name: "cross")!,
         backIcon: UIImage = UIImage.OKImageWith(name: "back")!,
         geolocIcon: UIImage = UIImage.OKImageWith(name: "geoloc")!,
         markerMinIcon: UIImage = UIImage.OKImageWith(name: "marker")!,
         mapIcon: UIImage = UIImage.OKImageWith(name: "map-view")!,
         mapMarker: UIImage = UIImage.OKImageWith(name: "map-marker")!,
         listIcon: UIImage = UIImage.OKImageWith(name: "list-view")!,
         sortIcon: UIImage = UIImage.OKImageWith(name: "sort")!,
         arrowRightIcon: UIImage = UIImage.OKImageWith(name: "arrow-right")!,
         mapGeolocIcon: UIImage = UIImage.OKImageWith(name: "geoloc")!,
         phoneIcon: UIImage = UIImage.OKImageWith(name: "phone-grey")!,
         faxIcon: UIImage = UIImage.OKImageWith(name: "fax-grey")!,
         websiteIcon: UIImage = UIImage.OKImageWith(name: "website")!,
         voteUpIcon: UIImage = UIImage.OKImageWith(name: "thumb_up")!,
         voteDownIcon: UIImage = UIImage.OKImageWith(name: "thumb_down")!,
         noResults: UIImage = UIImage.OKImageWith(name: "magnifier")!) {
        self.searchIcon = searchIcon
        self.profileIcon = profileIcon
        self.editIcon = editIcon
        self.crossIcon = crossIcon
        self.backIcon = backIcon
        self.geolocIcon = geolocIcon
        self.markerMinIcon = markerMinIcon
        self.mapIcon = mapIcon
        self.mapMarkerIcon = mapMarker
        self.listIcon = listIcon
        self.sortIcon = sortIcon
        self.arrowRightIcon = arrowRightIcon
        self.mapGeolocIcon = mapGeolocIcon
        self.phoneIcon = phoneIcon
        self.faxIcon = faxIcon
        self.websiteIcon = websiteIcon
        self.voteUpIcon = voteUpIcon
        self.voteDownIcon = voteDownIcon
        self.noResultsIcon = noResults
    }
}
