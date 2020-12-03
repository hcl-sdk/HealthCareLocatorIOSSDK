//
//  Helpers.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/27/20.
//

import Foundation
import MapKit
import CoreLocation

class Helper {
    static func openMapWithDirection(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        let userMark = MKMapItem(placemark: MKPlacemark(coordinate: from))
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: to))
        MKMapItem.openMaps(with: [userMark, destination],
                           launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    static func makeCallWith(phoneNumber: String) {
        let range = NSRange(location: 0, length: phoneNumber.count)
        let formatedPhoneNumber = try? NSRegularExpression(pattern: "[^0-9+]").stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
        guard let unwrapPhone = formatedPhoneNumber,
              let phoneUrl = URL(string: "tel://\(unwrapPhone)") else {
            return
        }
        UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
    }
 }
