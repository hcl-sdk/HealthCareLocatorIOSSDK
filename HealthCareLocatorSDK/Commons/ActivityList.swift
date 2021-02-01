//
//  ActivityList.swift
//  HealthCareLocatorSDK
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
    
    func getActivitiesCenter() -> CLLocationCoordinate2D? {
        if activities.count == 0 {
            return nil
        } else if activities.count == 1 {
            if let coordinate = activities.first?.activity.workplace.address.location {
                return CLLocationCoordinate2DMake(coordinate.lat,
                                                  coordinate.lon)
            } else {
                return nil
            }
        } else {
            var maxLatitude: Double = -200;
            var maxLongitude: Double = -200;
            var minLatitude: Double = Double(MAXFLOAT);
            var minLongitude: Double = Double(MAXFLOAT);
            
            for activity in activities where activity.activity.workplace.address.location != nil {
                let lat = activity.activity.workplace.address.location!.lat!
                let long = activity.activity.workplace.address.location!.lon!
                
                if lat < minLatitude {
                    minLatitude = lat
                }
                
                if long < minLongitude {
                    minLongitude = long
                }
                
                if lat > maxLatitude {
                    maxLatitude = lat
                }
                
                if long > maxLongitude {
                    maxLongitude = long
                }
                
            }
            return CLLocationCoordinate2DMake(CLLocationDegrees((maxLatitude + minLatitude) * 0.5),
                                              CLLocationDegrees((maxLongitude + minLongitude) * 0.5));
        }
    }
    
    func getFarestDistanceFrom(center: CLLocationCoordinate2D) -> CLLocationDistance {
        var distance: CLLocationDistance = 200 // The minimum distance from center to the map bounds
        let centerLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        for activity in activities where activity.activity.workplace.address.location != nil {
            let lat = activity.activity.workplace.address.location!.lat!
            let long = activity.activity.workplace.address.location!.lon!
            let location = CLLocation(latitude: lat, longitude: long)
            let newDistance = centerLocation.distance(from: location)
            if newDistance > distance {
                distance = newDistance
            }
        }
        return distance
    }
}
