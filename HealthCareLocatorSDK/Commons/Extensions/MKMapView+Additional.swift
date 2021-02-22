//
//  MKMapView+Additional.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/30/20.
//

import Foundation
import MapKit
import CoreLocation

extension MKMapView {
    func defaultZoomTo(location: CLLocationCoordinate2D, distance: CLLocationDistance = kDefaultZoomLevel) {
        let distanceForRegion = distance*1.1*2
        let maxDistance: CLLocationDistance = 20000000 // 20.000km
        setRegion(MKCoordinateRegion(center: location,
                                     latitudinalMeters: min(maxDistance, distanceForRegion),
                                     longitudinalMeters: min(maxDistance, distanceForRegion)),
                  animated: false)
    }
    
    func reload(annotations: [MKAnnotation]) {
        DispatchQueue.main.async {
            self.removeAnnotations(self.annotations)
            self.addAnnotations(annotations)
        }
    }
}
