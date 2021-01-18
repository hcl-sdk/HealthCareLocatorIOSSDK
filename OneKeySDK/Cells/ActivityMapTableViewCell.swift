//
//  ActivityMapTableViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import UIKit
import MapKit

class ActivityMapTableViewCell: CustomBorderTableViewCell, ViewDesign {
    var theme: OKThemeConfigure?
    
    @IBOutlet weak var mapView: MKMapView!
    
    weak var delegate: SearchHistoryDataSourceDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.isRotateEnabled = false
        mapView.register(SearchResultAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.delegate = self
    }
    
    func configWith(theme: OKThemeConfigure?, activities: [ActivityResult], center: CLLocationCoordinate2D?, isLastRow: Bool) {
        super.config(theme: theme, isLastRow: isLastRow)
        self.theme = theme
        let activityList = ActivityList(activities: activities)
        mapView.reload(annotations: activityList.getAnotations())
        if let location = center {
            mapView.defaultZoomTo(location: location)
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
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
                annotationView.markerTintColor = theme?.markerColor
                annotationView.clusteringIdentifier = SearchResultAnnotationView.preferredClusteringIdentifier
                return annotationView
            } else {
                let annotationView = SearchResultAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                annotationView.markerTintColor = theme?.markerColor
                annotationView.clusteringIdentifier = SearchResultAnnotationView.preferredClusteringIdentifier
                return annotationView
            }
        }
    }
}
