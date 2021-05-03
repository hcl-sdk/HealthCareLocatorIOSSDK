//
//  LocationManager.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/18/20.
//

import Foundation
import CoreLocation

typealias RequestLocationHandler = ([CLLocation]?, Error?) -> Void
typealias RequestAuthorizationHandler = (CLAuthorizationStatus) -> Void

class LocationManager: NSObject {
    static let shared = LocationManager()
    private var locationManager: CLLocationManager!
    var authorizationStatus: CLAuthorizationStatus!
    
    private var requestLocationHandler: RequestLocationHandler?
    private var requestAuthorizationHandler: RequestAuthorizationHandler?

    var currentLocation: CLLocation?
    
    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        authorizationStatus = .notDetermined
    }
    
    func requestAuthorization(_ completionHandler: @escaping ((CLAuthorizationStatus) -> Void)) {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse, .denied:
            completionHandler(authorizationStatus)
        default:
            requestAuthorizationHandler = completionHandler
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func requestLocation(_ completionHandler: @escaping (([CLLocation]?, Error?) -> Void)) {
        requestLocationHandler = completionHandler
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            completionHandler(nil, HCLError.locationAccessDenined)
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Store status
        authorizationStatus = status
        
        // Notify handler if any
        if let handler = requestAuthorizationHandler {
            handler(status)
        }
        
        // Update location
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        if let handler = requestLocationHandler {
            handler(locations, nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let handler = requestLocationHandler {
            handler(nil, error)
        }
    }
}
