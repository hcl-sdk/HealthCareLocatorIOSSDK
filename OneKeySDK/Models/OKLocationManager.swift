//
//  OKLocationManager.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/18/20.
//

import Foundation
import CoreLocation

typealias RequestLocationHandler = ([CLLocation]) -> Void
typealias RequestAuthorizationHandler = (CLAuthorizationStatus) -> Void

class OKLocationManager: NSObject {
    static let shared = OKLocationManager()
    private var locationManager: CLLocationManager!
    var authorizationStatus: CLAuthorizationStatus!
    
    private var requestLocationHandler: RequestLocationHandler?
    private var requestAuthorizationHandler: RequestAuthorizationHandler?

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
    
    func requestLocation(_ completionHandler: @escaping (([CLLocation]) -> Void)) {
        requestLocationHandler = completionHandler
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            completionHandler([])
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension OKLocationManager: CLLocationManagerDelegate {
    
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
        if let handler = requestLocationHandler {
            handler(locations)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
