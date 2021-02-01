//
//  ActivityMapTableViewCell.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit
import MapKit

class ActivityMapTableViewCell: CustomBorderTableViewCell, ViewDesign {

    @IBOutlet weak var mapView: MKMapView!
    
    weak var delegate: SearchHistoryDataSourceDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.register(SearchResultAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.isRotateEnabled = false
        mapView.delegate = self
    }
    
    func configWith(theme: HCLThemeConfigure?, activities: [ActivityResult], center: CLLocationCoordinate2D?, isLastRow: Bool) {
        super.config(theme: theme, isLastRow: isLastRow)
        let activityList = ActivityList(activities: activities)
        mapView.reload(annotations: activityList.getAnotations())
        if let location = center {
            mapView.defaultZoomTo(location: location, distance: ActivityList(activities: activities).getFarestDistanceFrom(center: location))
        }
    }
    
    @IBAction func onTapAction(_ sender: Any) {
        delegate?.didSelectNearMeSearch()
    }
    
}

extension ActivityMapTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
          return nil
        } else {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) {
                return annotationView
            } else {
                let annotationView = SearchResultAnnotationView(annotation: annotation,
                                                                reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                return annotationView
            }
        }
    }
}
