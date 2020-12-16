//
//  ActivityList.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import Foundation
import CoreLocation
import MapKit

struct ActivityList {
    let activities: [ActivityResult]
    
    func getLocations() -> [CLLocationCoordinate2D] {
        return activities.compactMap { (item) -> CLLocationCoordinate2D? in
            guard let location = item.activity.workplace.address.location else {return nil}
            return CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)
        }
    }
    
    func getAnotations() -> [MKAnnotation] {
        return getLocations().compactMap { (item) -> MKAnnotation? in
            let annotation = MKPointAnnotation()
            annotation.coordinate = item
            return annotation
        }
    }
}
