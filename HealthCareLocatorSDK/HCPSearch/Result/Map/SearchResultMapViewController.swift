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
    //
    weak var delegate: ActivityHandler? {
        didSet {
            if isViewLoaded {
                cardCollectionViewController.delegate = delegate
            }
        }
    }
    var result: [ActivityResult] = []
    var distanceFromBBox: Double = 0.0

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
        currentLocationWrapper.backgroundColor = theme.darkmode ? kDarkColor : .white
        currentLocationWrapper.borderWidth = 1
        currentLocationWrapper.borderColor = theme.cardBorderColor
        reLaunchWrapper.backgroundColor = theme.secondaryColor
        relaunchIcon.tintColor = .white
        relaunchLabel.textColor = .white
        relaunchLabel.font = theme.defaultFont
        relaunchLabel.text = "hcl_relaunch".localized
    }
    
    private func configure(mapView: MKMapView) {
        if #available(iOS 13.0, *), theme.darkmodeForMap {
            mapView.overrideUserInterfaceStyle = .dark
        }
        mapView.delegate = self
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.register(SearchResultAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    private func addMapPinFor(result: [ActivityResult]) {
        var annotations: [MKAnnotation] = []
        for activity in result {
            let lat = activity.activity.workplace.address.location?.lat ?? 0
            let long = activity.activity.workplace.address.location?.lon ?? 0
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                annotations.append(annotation)
        }
        mapView.reload(annotations: annotations)
    }
    
    private func reloadHorizontalListWith(selectedIndexs: [Int]) {
        cardCollectionViewController.selectedIndexs = selectedIndexs
        SearchResultListViewController.shared.selectedLocations.removeAll()
        selectedIndexs.forEach { index in
            if let location = result[index].activity.workplace.address.location {
                SearchResultListViewController.shared.selectedLocations.append(location)
            }
        }
        if let first = selectedIndexs.first {
            cardCollectionViewController.collectionView.scrollToItem(at: IndexPath(row: first, section: 0),
                                                                     at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func currentLocationAction(_ sender: Any) {
        mapDelegate?.startNewNearMeSearchFrom(view: self)
    }
    
    @IBAction func relaunchAction(_ sender: Any) {
        // Reset selectedIndexs
        cardCollectionViewController.selectedIndexs = []
        SearchResultListViewController.shared.selectedLocations = []
        
        //
        reLaunchWrapper.isHidden = true
        OSMWebService.getBoundingbox(from: mapView.centerCoordinate, completion: { [weak self] result, error in
            guard let strongSelf = self,
                  let result = result else { return }
            if let boundingbox = result.boundingbox, boundingbox.count == 4 {
                strongSelf.distanceFromBBox = strongSelf.getDistanceFromBoundingBox(lat1: Double(boundingbox[0]) ?? 0,
                                                                                    lon1: Double(boundingbox[1]) ?? 0,
                                                                                    lat2: Double(boundingbox[2]) ?? 0,
                                                                                    lon2: Double(boundingbox[3]) ?? 0)
                strongSelf.mapDelegate?.startNewSearchWith(location: strongSelf.mapView.centerCoordinate, from: strongSelf)
            }
        })
    }
    
    private func getDistanceFromBoundingBox(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let absoluteLatDiff = abs(lat2 - lat1)
        let latDiff = degreesToRadian(number: absoluteLatDiff)
        let absoluteLonDiff = abs(lon2 - lon1)
        let lngDiff = degreesToRadian(number: absoluteLonDiff)
        let a = sin(latDiff / 2) * sin(latDiff / 2) +
            cos(degreesToRadian(number: lat1)) * cos(degreesToRadian(number: lat2)) *
            sin(lngDiff / 2) * sin(lngDiff / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        return EARTH_RADIUS_IN_METERS * c
    }
    
    private func degreesToRadian(number: Double) -> Double {
        return number * .pi / 180
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
           lastCenter.latitude != mapView.centerCoordinate.latitude
            && lastCenter.longitude != mapView.centerCoordinate.longitude {
            reLaunchWrapper.isHidden = false
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
          return nil
        } else {
            var annotationView: SearchResultAnnotationView!
            if let view = mapView.dequeueReusableAnnotationView(
                withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? SearchResultAnnotationView {
                annotationView = view
            } else {
                annotationView = SearchResultAnnotationView(annotation: annotation,
                                                            reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
            }
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
        result = data
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
