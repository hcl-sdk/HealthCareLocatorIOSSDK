//
//  HCPMapViewModel.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/23/20.
//

import Foundation
import MapKit

class HCPMapViewModel {
    func layout(view: HCPMapViewController, with theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        view.closeButton.setImage(icons.crossIcon, for: .normal)
        view.geolocImageView.image = icons.geolocIcon
        view.markerIcon.image = icons.markerMinIcon
        view.currentLocationWrapper.borderColor = theme.cardBorderColor
        view.workplaceLabel.font = theme.defaultFont
        view.addressLabel.font = theme.defaultFont
        
        view.mapWrapper.borderColor = theme.cardBorderColor
        view.markerIcon.tintColor = theme.markerColor
        view.workplaceLabel.textColor = theme.secondaryColor
        view.addressLabel.textColor = theme.darkColor
        view.closeButton.tintColor = theme.greyDarkColor
    }
    
    func layout(view: HCPMapViewController, with activity: Activity) {
        view.workplaceLabel.text = activity.workplace.name
        view.addressLabel.text = activity.workplace.address.composedAddress
        if let location = activity.workplace.address.location {
            let coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            view.mapView.addAnnotation(annotation)
            view.mapView.setCamera(MKMapCamera(lookingAtCenter: coordinate,
                                          fromDistance: kDefaultZoomLevel,
                                          pitch: 0,
                                          heading: 0),
                              animated: false)
        }
    }
    
    func moveMapToCurrentLocation(map: MKMapView) {
        LocationManager.shared.requestLocation { (locations, error) in
            if let location = locations?.last {
                map.setCamera(MKMapCamera(lookingAtCenter: location.coordinate,
                                          fromDistance: kDefaultZoomLevel,
                                          pitch: 0,
                                          heading: 0),
                              animated: true)
            } else if let error = error {
                // TODO: Handle error
                print(error)
            }
        }
    }
}
