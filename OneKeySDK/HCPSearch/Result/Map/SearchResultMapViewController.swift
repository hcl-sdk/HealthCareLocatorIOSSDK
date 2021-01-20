//
//  SearchResultMapViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit
import MapKit
import CoreLocation

protocol SearchResultMapViewControllerDelegate {
    func startNewNearMeSearchFrom(view: SearchResultMapViewController)
    func startNewSearchWith(location: CLLocationCoordinate2D, from view: SearchResultMapViewController)
}

class SearchResultMapViewController: UIViewController, ViewDesign, ActivityListHandler {
    //
    weak var delegate: ActivityHandler? {
        didSet {
            if isViewLoaded {
                cardCollectionViewController.delegate = delegate
            }
        }
    }
    var result: [ActivityResult] = []

    @IBOutlet weak var currentLocationBtn: BaseButton!
    @IBOutlet weak var currentLocationWrapper: BaseView!
    @IBOutlet weak var geolocIcon: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    // Re-launch UI
    @IBOutlet weak var reLaunchWrapper: BaseView!
    @IBOutlet weak var relaunchIcon: UIImageView!
    @IBOutlet weak var relaunchLabel: UILabel!
    
    
    var searchData: SearchData?
    var mapDelegate: SearchResultMapViewControllerDelegate?

    private var cardCollectionViewController: HCPCardCollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(mapView: mapView)
        reloadWith(data: result)
        layoutWith(theme: theme, icons: icons)

        if let data = searchData {
            switch data.mode {
            case .nearMeSearch,
                 .quickNearMeSearch:
                if let currentLocation = LocationManager.shared.currentLocation {
                    defaultZoomTo(location: currentLocation.coordinate)
                }
            default:
                if let location = result.first(where: {$0.activity.workplace.address.location != nil})?.activity.workplace.address.location {
                    defaultZoomTo(location: CLLocationCoordinate2DMake(location.lat, location.lon))
                }
            }
        }
    }
    
    func layoutWith(theme: OKThemeConfigure, icons: OKIconsConfigure) {
        currentLocationWrapper.borderWidth = 1
        currentLocationWrapper.borderColor = theme.cardBorderColor
        reLaunchWrapper.backgroundColor = theme.secondaryColor
        relaunchIcon.tintColor = .white
        relaunchLabel.textColor = .white
        relaunchLabel.font = theme.defaultFont
        relaunchLabel.text = "onekey_sdk_relaunch".localized
    }
    
    private func configure(mapView: MKMapView) {
        mapView.delegate = self
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.register(SearchResultAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(SearchResultClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    
    private func addMapPinFor(result: [ActivityResult]) {
        mapView.reload(annotations: ActivityList(activities: result).getAnotations())
    }
    
    private func reloadHorizontalListWith(selectedIndex: Int) {
        cardCollectionViewController.selectedIndex = selectedIndex
        cardCollectionViewController.collectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func currentLocationAction(_ sender: Any) {
        mapDelegate?.startNewNearMeSearchFrom(view: self)
    }
    
    @IBAction func relaunchAction(_ sender: Any) {
        reLaunchWrapper.isHidden = true
        mapDelegate?.startNewSearchWith(location: mapView.centerCoordinate, from: self)
    }
    
    func defaultZoomTo(location: CLLocationCoordinate2D) {
        mapView.defaultZoomTo(location: location)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "EmbedHCPCard":
                if let desVC = segue.destination as? HCPCardCollectionViewController {
                    desVC.result = result
                    desVC.delegate = delegate
                    cardCollectionViewController = desVC
                }
            default:
                return
            }
        }
    }
}

extension SearchResultMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if let currentLocation = LocationManager.shared.currentLocation {
            reLaunchWrapper.isHidden = mapView.visibleMapRect.contains(MKMapPoint(currentLocation.coordinate))
        } else {
            reLaunchWrapper.isHidden = false
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
          return nil
        } else {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
                annotationView.markerTintColor = theme.markerColor
                annotationView.clusteringIdentifier = SearchResultAnnotationView.preferredClusteringIdentifier
                return annotationView
            } else {
                let annotationView = SearchResultAnnotationView(annotation: annotation, reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                annotationView.markerTintColor = theme.markerColor
                annotationView.clusteringIdentifier = SearchResultAnnotationView.preferredClusteringIdentifier
                return annotationView
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let marker = view as? MKMarkerAnnotationView {
            marker.markerTintColor = theme.markerSelectedColor
            let annotation = view.annotation
            if let index = result.firstIndex(where: {$0.activity.workplace.address.location?.lat == annotation?.coordinate.latitude && $0.activity.workplace.address.location?.lon == annotation?.coordinate.longitude}) {
                reloadHorizontalListWith(selectedIndex: index)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let marker = view as? MKMarkerAnnotationView {
            marker.markerTintColor = theme.markerColor
        }
    }
}

extension SearchResultMapViewController: SortableResultList {
    func reloadWith(data: [ActivityResult]) {
        self.result = data
        if isViewLoaded {
            addMapPinFor(result: data)
            cardCollectionViewController.reloadWith(data: data)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let strongSelf = self else {return}
                strongSelf.reloadWith(data: data)
            }
        }
    }
}
