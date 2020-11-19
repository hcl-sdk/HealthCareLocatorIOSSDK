//
//  OKHCPSearchResultMapViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit
import MapKit
import CoreLocation

class OKHCPSearchResultMapViewController: UIViewController, OKViewDesign {
    var theme: OKThemeConfigure?
    
    private let locationManager = CLLocationManager()
    
    var result: [Activity] = []

    @IBOutlet weak var mapView: MKMapView!
    private var cardCollectionViewController: HCPCardCollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(manager: locationManager)
        configure(mapView: mapView)
        addMapPinFor(result: result)
    }
    
    private func configure(manager: CLLocationManager) {
        manager.delegate = self
        manager.requestLocation()
        manager.requestAlwaysAuthorization()
    }
    
    private func configure(mapView: MKMapView) {
        mapView.delegate = self
        mapView.isRotateEnabled = false
        mapView.register(SearchResultAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(SearchResultClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        if let location = result.first(where: {$0.workplace.address.location != nil})?.workplace.address.location {
            mapView.setCenter(CLLocationCoordinate2DMake(location.lat, location.long), animated: true)
        }
    }
    
    private func addMapPinFor(result: [Activity]) {
        let annotations = result.compactMap { (item) -> MKAnnotation? in
            guard let location = item.workplace.address.location else {return nil}
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            return annotation
        }
        mapView.addAnnotations(annotations)
    }
    
    @IBAction func currentLocationAction(_ sender: Any) {
        guard let coordinate = locationManager.location?.coordinate else {return}
        mapView.setCenter(coordinate, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "EmbedHCPCard":
                if let desVC = segue.destination as? HCPCardCollectionViewController {
                    desVC.result = result
                    desVC.theme = theme
                    cardCollectionViewController = desVC
                }
            default:
                return
            }
        }
    }
}

extension OKHCPSearchResultMapViewController: CLLocationManagerDelegate {
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,
             .authorizedWhenInUse:
            manager.requestLocation()
        default:
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension OKHCPSearchResultMapViewController: MKMapViewDelegate {
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let marker = view as? MKMarkerAnnotationView {
            marker.markerTintColor = theme?.selectedMarkerColor
            let annotation = view.annotation
            if let index = result.firstIndex(where: {$0.workplace.address.location?.lat == annotation?.coordinate.latitude && $0.workplace.address.location?.long == annotation?.coordinate.longitude}) {
                cardCollectionViewController.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let marker = view as? MKMarkerAnnotationView {
            marker.markerTintColor = theme?.markerColor
        }
    }
}
