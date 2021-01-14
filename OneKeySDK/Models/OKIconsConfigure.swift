//
//  OKIconsConfigure.swift
//  OneKeySDK
//
//  Created by Truong Le on 1/11/21.
//

import Foundation
import UIKit

public struct OKIconsConfigure {
    let searchIcon: UIImage!
    let profileIcon: UIImage!
    let editIcon: UIImage!
    let crossIcon: UIImage!
    let backIcon: UIImage!
    let geolocIcon: UIImage!
    let markerMinIcon: UIImage!
    let mapIcon: UIImage!
    let listIcon: UIImage!
    let sortIcon: UIImage!
    let arrowRightIcon: UIImage!
    let mapGeolocIcon: UIImage!
    let phoneIcon: UIImage!
    let faxIcon: UIImage!
    let websiteIcon: UIImage!
    let voteUpIcon: UIImage!
    let voteDownIcon: UIImage!
    
    public init(searchIcon: UIImage = UIImage.OKImageWith(name: "magnifier")!,
         profileIcon: UIImage = UIImage.OKImageWith(name: "profile")!,
         editIcon: UIImage = UIImage.OKImageWith(name: "edit")!,
         crossIcon: UIImage = UIImage.OKImageWith(name: "cross")!,
         backIcon: UIImage = UIImage.OKImageWith(name: "back")!,
         geolocIcon: UIImage = UIImage.OKImageWith(name: "geoloc")!,
         markerMinIcon: UIImage = UIImage.OKImageWith(name: "marker")!,
         mapIcon: UIImage = UIImage.OKImageWith(name: "map-view")!,
         listIcon: UIImage = UIImage.OKImageWith(name: "list-view")!,
         sortIcon: UIImage = UIImage.OKImageWith(name: "sort")!,
         arrowRightIcon: UIImage = UIImage.OKImageWith(name: "arrow-right")!,
         mapGeolocIcon: UIImage = UIImage.OKImageWith(name: "geoloc")!,
         phoneIcon: UIImage = UIImage.OKImageWith(name: "phone-grey")!,
         faxIcon: UIImage = UIImage.OKImageWith(name: "fax-grey")!,
         websiteIcon: UIImage = UIImage.OKImageWith(name: "website")!,
         voteUpIcon: UIImage = UIImage.OKImageWith(name: "thumb_up")!,
         voteDownIcon: UIImage = UIImage.OKImageWith(name: "thumb_down")!) {
        self.searchIcon = searchIcon
        self.profileIcon = profileIcon
        self.editIcon = editIcon
        self.crossIcon = crossIcon
        self.backIcon = backIcon
        self.geolocIcon = geolocIcon
        self.markerMinIcon = markerMinIcon
        self.mapIcon = mapIcon
        self.listIcon = listIcon
        self.sortIcon = sortIcon
        self.arrowRightIcon = arrowRightIcon
        self.mapGeolocIcon = mapGeolocIcon
        self.phoneIcon = phoneIcon
        self.faxIcon = faxIcon
        self.websiteIcon = websiteIcon
        self.voteUpIcon = voteUpIcon
        self.voteDownIcon = voteDownIcon
    }
}
