//
//  HCPMapViewController.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/23/20.
//

import UIKit
import MapKit

class HCPMapViewController: UIViewController, ViewDesign {
    var activity: Activity?
    
    private let viewModel = HCPMapViewModel()
    
    @IBOutlet weak var markerIcon: UIImageView!
    @IBOutlet weak var workplaceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var mapWrapper: BaseView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentLocationWrapper: BaseView!
    @IBOutlet weak var currentLocationButton: BaseButton!
    @IBOutlet weak var geolocImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(SearchResultAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

        layoutWith(theme: theme, icons: icons)
        if let activity = activity {
            layoutWith(activity: activity)
        }
    }
    
    func layoutWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        viewModel.layout(view: self, with: theme, icons: icons)
    }
    
    func layoutWith(activity: Activity) {
        viewModel.layout(view: self, with: activity)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func currentLocationAction(_ sender: Any) {
        viewModel.moveMapToCurrentLocation(map: mapView)
    }
}

extension HCPMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
          return nil
        } else {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) {
                return annotationView
            } else {
                let annotationView = SearchResultAnnotationView(annotation: annotation,
                                                                reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                annotationView.set(selected: true)
                return annotationView
            }
        }
    }
}
