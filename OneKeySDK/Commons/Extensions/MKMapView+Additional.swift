//
//  MKMapView+Additional.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import Foundation
import MapKit
import CoreLocation

extension MKMapView {
    func defaultZoomTo(location: CLLocationCoordinate2D) {
        setCamera(MKMapCamera(lookingAtCenter: location,
                              fromDistance: 12000,
                              pitch: 0,
                              heading: 0),
                  animated: false)
    }
}
