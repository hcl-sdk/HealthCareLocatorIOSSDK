//
//  ActivityMapTableViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit
import MapKit

class ActivityMapTableViewCell: CustomBorderTableViewCell, OKViewDesign {
    var theme: OKThemeConfigure?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.isRotateEnabled = false
        mapView.register(SearchResultAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.delegate = self
    }
    
    func configWith(theme: OKThemeConfigure?, activities: [Activity], isLastRow: Bool) {
        super.config(isLastRow: isLastRow)
        self.theme = theme
        let activityList = ActivityList(activities: activities)
        mapView.addAnnotations(activityList.getAnotations())
        if let location = activityList.getLocations().first {
            mapView.defaultZoomTo(location: location)
        }
    }
    
    
}

extension ActivityMapTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
          return nil
        } else {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
                annotationView.markerTintColor = theme?.markerColor
                return annotationView
            } else {
                let annotationView = SearchResultAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                annotationView.markerTintColor = theme?.markerColor
                return annotationView
            }
        }
    }
}
