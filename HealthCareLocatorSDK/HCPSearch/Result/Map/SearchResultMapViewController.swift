//
//  SearchResultMapViewController.swift
//  HealthCareLocatorSDK
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
    private var sameAddressCounting = [String : Int]()
    
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
    
    private var lastCenter: CLLocationCoordinate2D?
    
    var searchData: SearchData?
    var mapDelegate: SearchResultMapViewControllerDelegate?

    private var cardCollectionViewController: HCPCardCollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(mapView: mapView)
        reloadWith(data: result)
        layoutWith(theme: theme, icons: icons)
        if result.count > 0 {
            let activityList = ActivityList(activities: result)
            if let center = activityList.getActivitiesCenter() {
                defaultZoomTo(location: center, distance: activityList.getFarestDistanceFrom(center: center))
            }
        } else if let currentLocation = LocationManager.shared.currentLocation {
            defaultZoomTo(location: currentLocation.coordinate)
        }
    }
    
    func layoutWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        geolocIcon.image = icons.geolocIcon
        currentLocationWrapper.borderWidth = 1
        currentLocationWrapper.borderColor = theme.cardBorderColor
        reLaunchWrapper.backgroundColor = theme.secondaryColor
        relaunchIcon.tintColor = .white
        relaunchLabel.textColor = .white
        relaunchLabel.font = theme.defaultFont
        relaunchLabel.text = "hcl_relaunch".localized
    }
    
    private func configure(mapView: MKMapView) {
        mapView.delegate = self
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.register(SearchResultAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    private func addMapPinFor(result: [ActivityResult]) {
        sameAddressCounting = [String : Int]()
        var annotations: [MKAnnotation] = []
        for activity in result {
            let lat = activity.activity.workplace.address.location?.lat ?? 0
            let long = activity.activity.workplace.address.location?.lon ?? 0
            if let val = sameAddressCounting["\(lat)_\(long)"] {
                sameAddressCounting["\(lat)_\(long)"] = val + 1
            } else {
                sameAddressCounting["\(lat)_\(long)"] = 1
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                annotations.append(annotation)
            }
        }
        mapView.reload(annotations: annotations)
    }
    
    private func reloadHorizontalListWith(selectedIndexs: [Int]) {
        cardCollectionViewController.selectedIndexs = selectedIndexs
        if let first = selectedIndexs.first {
            cardCollectionViewController.collectionView.scrollToItem(at: IndexPath(row: first, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func currentLocationAction(_ sender: Any) {
        mapDelegate?.startNewNearMeSearchFrom(view: self)
    }
    
    @IBAction func relaunchAction(_ sender: Any) {
        reLaunchWrapper.isHidden = true
        mapDelegate?.startNewSearchWith(location: mapView.centerCoordinate, from: self)
    }
    
    func defaultZoomTo(location: CLLocationCoordinate2D, distance: CLLocationDistance = kDefaultZoomLevel) {
        lastCenter = location
        mapView.defaultZoomTo(location: location, distance: distance)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.reLaunchWrapper.isHidden = true
        }
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
        if let lastCenter = lastCenter,
           lastCenter.latitude != mapView.centerCoordinate.latitude && lastCenter.longitude != mapView.centerCoordinate.longitude {
            reLaunchWrapper.isHidden = false
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
          return nil
        } else {
            var annotationView: SearchResultAnnotationView!
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? SearchResultAnnotationView {
                annotationView = view
            } else {
                annotationView = SearchResultAnnotationView(annotation: annotation,
                                                            reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            }
            let key = "\(annotation.coordinate.latitude)_\(annotation.coordinate.longitude)"
            annotationView.set(counting: sameAddressCounting[key] ?? 0)
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let marker = view as? SearchResultAnnotationView {
            marker.set(selected: true)
            let annotation = view.annotation
            var selectedIndexs = [Int]()
            for (index, activity) in result.enumerated() {
                if activity.activity.workplace.address.location?.lat == annotation?.coordinate.latitude &&
                    activity.activity.workplace.address.location?.lon == annotation?.coordinate.longitude {
                    selectedIndexs.append(index)
                }
            }
            reloadHorizontalListWith(selectedIndexs: selectedIndexs)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let marker = view as? SearchResultAnnotationView {
            marker.set(selected: false)
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
