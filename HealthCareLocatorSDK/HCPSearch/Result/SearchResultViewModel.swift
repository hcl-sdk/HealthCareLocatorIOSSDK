//
//  SearchResultViewModel.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/16/20.
//

import Foundation
import UIKit
import MapKit
import RxSwift

class SearchResultViewModel: ViewLoading {
    lazy var indicator = UIActivityIndicatorView(style: .gray)
    
    private var webServices: SearchAPIsProtocol!
    private var search: SearchData!
    private let searchActions = PublishSubject<SearchResultViewModel.SearchAction>()
    
    init(webservices: SearchAPIsProtocol, search: SearchData) {
        self.webServices = webservices
        self.search = search
    }
    
    // MARK: Searching
    func performSearch(config: HCLSDKConfigure, completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        switch search.mode {
        case .nearMeSearch,
             .quickNearMeSearch:
            perform(action: SearchAction(isNearMeSearch: true,
                                         address: nil,
                                         coordinate: nil,
                                         distance: kDefaultSearchNearMeDistance,
                                         country: nil))
        case .addressSearch(let address):
            CLGeocoder().geocodeAddressString(address) {[weak self]  (placeMarks, error) in
                guard let strongSelf = self, let place = placeMarks?.first else {return}
                if let region = place.region as? CLCircularRegion {
                    strongSelf.perform(action: SearchAction(isNearMeSearch: false,
                                                            address: address,
                                                            coordinate: place.location?.coordinate,
                                                            distance: region.radius,
                                                            country: nil))
                } else {
                    let street = place.thoroughfare
                    let city = place.locality
                    
                    if street != nil {
                        strongSelf.perform(action: SearchAction(isNearMeSearch: false,
                                                                address: address,
                                                                coordinate: place.location?.coordinate,
                                                                distance: kDefaultSearchAddressDistance,
                                                                country: nil))
                    } else if city != nil {
                        strongSelf.perform(action: SearchAction(isNearMeSearch: false,
                                                                address: address,
                                                                coordinate: place.location?.coordinate,
                                                                distance: kDefaultSearchCityDistance,
                                                                country: nil))
                    } else {
                        if let countryCode = place.isoCountryCode {
                            strongSelf.perform(action: SearchAction(isNearMeSearch: false,
                                                                    address: address,
                                                                    coordinate: place.location?.coordinate,
                                                                    distance: nil,
                                                                    country: countryCode))
                        } else {
                            strongSelf.perform(action: SearchAction(isNearMeSearch: false,
                                                                    address: address,
                                                                    coordinate: place.location?.coordinate,
                                                                    distance: nil,
                                                                    country: nil))
                        }
                    }
                }
            }
        case .baseSearch(let country):
            perform(action: SearchAction(isNearMeSearch: false, address: nil, coordinate: nil, distance: nil, country: country))
        default:
            perform(action: SearchAction(isNearMeSearch: false, address: nil, coordinate: nil, distance: nil, country: nil))
        }
    }
    
    func performSearchWith(config: HCLSDKConfigure,
                           coordinate: GeopointQuery?,
                           completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        let info = GeneralQueryInput(first: 50,
                                     offset: 0,
                                     locale: config.lang.apiCode,
                                     criteria: search.codes != nil ? nil : search.criteria)
        fetchActivitiesWith(info: info,
                            specialties: search.codes?.map {$0.id},
                            location: coordinate,
                            county: "",
                            criteria: info.criteria,
                            userId: config.userId,
                            completionHandler: completionHandler)
    }
    
    private func fetchActivitiesWith(info: GeneralQueryInput,
                                     specialties: [String]?,
                                     location: GeopointQuery?,
                                     county: String?,
                                     criteria: String!,
                                     userId: String?,
                                     completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        webServices.fetchActivitiesWith(info: info,
                                        specialties: specialties,
                                        location: location,
                                        county: county,
                                        criteria: criteria,
                                        userId: userId) { (result, error) in
            if let unwrapResult = result {
                completionHandler(unwrapResult, nil)
            } else {
                if let error = error {
                    completionHandler(nil, error)
                } else {
                    completionHandler([], nil)
                }
            }
        }
    }
    
    func fetchLabelFor(code: String, completionHandler: @escaping ((Code?, Error?) -> Void)) {
        webServices.fetchLabelBy(code: code, completionHandler: completionHandler)
    }
    
    // MARK: Sorting
    func sortResultBy(sort: SearchResultSortViewController.SortBy, result: [ActivityResult], _ completionHandler: (([ActivityResult]) -> Void)) {
        var mutableResult = result
        switch sort {
        case .name:
            mutableResult.sort { (lhs, rhs) -> Bool in
                return lhs.activity.individual.lastName < rhs.activity.individual.lastName
            }
        case .distance:
            mutableResult.sort { (lhs, rhs) -> Bool in
                return lhs.distance ?? 0 < rhs.distance ?? 0
            }
        case .relevance:
            mutableResult.sort { (lhs, rhs) -> Bool in
                return lhs.relevance ?? 0 < rhs.relevance ?? 0
            }
        }
        completionHandler(mutableResult)
    }
    
    func layout(view: SearchResultViewController, theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        view.searchButton.setImage(icons.searchIcon, for: .normal)
        view.resultsLabel.text = "hcl_results_label".localized
        view.listLabel.text = "hcl_list_label".localized
        view.mapLabel.text = "hcl_map_label".localized
        view.listIcon.image = icons.listIcon
        view.mapIcon.image = icons.mapIcon
        view.sortButton.setImage(icons.sortIcon, for: .normal)
        
        // Fonts
        view.resultsLabel.font = theme.searchResultTotalFont
        view.criteriaLabel.font = theme.searchResultTitleFont
        view.addressLabel.font = theme.smallFont
        view.activityCountLabel.font = theme.smallFont
        view.topInputTextField.font = theme.searchInputFont
        
        // Colors
        view.searchButton.backgroundColor = theme.primaryColor
        view.resultsLabel.textColor = theme.darkColor
        view.sortButtonBackground.backgroundColor = theme.secondaryColor
        view.activityCountLabel.textColor = theme.primaryColor
        view.criteriaLabel.textColor = theme.darkColor
        view.addressLabel.textColor = theme.greyColor
        view.backButton.tintColor = theme.darkColor
        view.firstSeparatorView.backgroundColor = theme.greyLighterColor
        view.secondSeparatorView.backgroundColor = theme.greyLighterColor
        view.topInputTextField.textColor = theme.darkColor
        view.topInputTextField.attributedPlaceholder = NSAttributedString(string: "hcl_find_healthcare_professional".localized,
                                                                     attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        layout(view: view, theme: theme, mode: .list)
    }
    
    func layout(view: SearchResultViewController, theme: HCLThemeConfigure, mode: SearchResultViewController.ViewMode) {
        switch mode {
        case .list:
            view.selectedListViewBackgroundView.backgroundColor = theme.primaryColor
            view.listLabel.textColor = UIColor.white
            view.listIcon.tintColor = UIColor.white
            
            view.selectedMapViewBackgroundView.backgroundColor = UIColor.clear
            view.mapLabel.textColor = theme.darkColor
            view.mapIcon.tintColor = theme.darkColor
            
        case .map:
            view.selectedMapViewBackgroundView.backgroundColor = theme.primaryColor
            view.mapLabel.textColor = UIColor.white
            view.mapIcon.tintColor = UIColor.white
            
            view.selectedListViewBackgroundView.backgroundColor = UIColor.clear
            view.listLabel.textColor = theme.darkColor
            view.listIcon.tintColor = theme.darkColor
        }
    }
    
    func layoutWith(view: SearchResultViewController, searchData: SearchData) {
        view.addressLabel.text = " "// use space char to keep the line height
        view.criteriaLabel.text = searchData.codes?.first?.longLbl ?? searchData.criteria ?? " "
        switch searchData.mode {
        case .baseSearch:
            view.addressLabel.text = kNoAddressTitle
            view.topInputWrapper.isHidden = true
            view.topLabelsWrapper.isHidden = false
            view.mode = .list
        case .quickNearMeSearch:
            view.addressLabel.text = kNearMeTitle
            view.topInputWrapper.isHidden = false
            view.topLabelsWrapper.isHidden = true
            view.mode = .map
        case .addressSearch(let address):
            view.addressLabel.text = address
            view.topInputWrapper.isHidden = true
            view.topLabelsWrapper.isHidden = false
            view.mode = .list
        default:
            view.addressLabel.text = kNearMeTitle
            view.topInputWrapper.isHidden = true
            view.topLabelsWrapper.isHidden = false
            view.mode = .map
        }
        // Try to fetch label for code
        if let code = searchData.codes?.first {
            fetchLabelFor(code: code.id) {[weak view] (codeObj, error) in
                view?.criteriaLabel.text = codeObj?.longLbl ?? code.id
            }
        }
    }
}

// MARK: Convert user action on map to the search request, handle race conditions to avoid wrong result displyed while the user is continous spam on the button
extension SearchResultViewModel {
    
    struct SearchAction {
        let isNearMeSearch: Bool
        let address: String?
        let coordinate: CLLocationCoordinate2D?
        let distance: Double?
        let country: String?
    }
    
    private func reverseGeocodeLocation(location: CLLocation) -> Single<String?> {
        return Single.create { single in
            CLGeocoder().reverseGeocodeLocation(location) {(places, _) in
                single(.success(places?.first?.name))
            }
            return Disposables.create {}
        }
    }
    
    private func requestCurrentLocation() -> Single<CLLocation?> {
        return Single.create { single in
            LocationManager.shared.requestLocation { (locations, error) in
                single(.success(locations?.last))
            }
            return Disposables.create {}
        }
    }
    
    private func searchWith(config: HCLSDKConfigure, coordinate: GeopointQuery?) -> Single<[ActivityResult]> {
        return Single.create {[weak self] single in
            if let strongSelf = self {
                strongSelf.performSearchWith(config: config,
                                             coordinate: coordinate,
                                             completionHandler: { (result, error) in
                                                            single(.success(result ?? []))
                                                         })
            } else {
                single(.success([]))
            }
            return Disposables.create {}
        }
    }
    
    func perform(action: SearchAction) {
        searchActions.onNext(action)
    }
    
    func newSearchWith(config: HCLSDKConfigure,
                       address: String?,
                       location: CLLocationCoordinate2D?,
                       distance: Double?,
                       country: String?) -> Single<(title: String?, result: [ActivityResult], zoomTo: CLLocationCoordinate2D?)> {
        if let unwrapLocation = location {
            if let unwrapAddress = address {
                return searchWith(config: config, coordinate: GeopointQuery(lat: unwrapLocation.latitude,
                                                                            lon: unwrapLocation.longitude,
                                                                            distanceMeter: distance)).map {(title: unwrapAddress, result: $0, zoomTo: nil)}
            } else {
                return Single.zip(reverseGeocodeLocation(location: CLLocation(latitude: unwrapLocation.latitude,
                                                                              longitude: unwrapLocation.longitude)),
                                  searchWith(config: config, coordinate: GeopointQuery(lat: unwrapLocation.latitude,
                                                                                       lon: unwrapLocation.longitude,
                                                                                       distanceMeter: distance))).map {(title: $0.0, result: $0.1, zoomTo: nil)}
            }
        } else {
            return searchWith(config: config, coordinate: nil).map {(title: address ?? kNoAddressTitle, result: $0, zoomTo: nil)}
        }
    }
    
    func newNearMeSearchWith(config: HCLSDKConfigure) -> Single<(title: String?, result: [ActivityResult], zoomTo: CLLocationCoordinate2D?)> {
        return requestCurrentLocation().flatMap {[weak self] (location) -> Single<(title: String?, result: [ActivityResult], zoomTo: CLLocationCoordinate2D?)> in
            if let strongSelf = self, let unwrap = location {
                return strongSelf.searchWith(config: config, coordinate: GeopointQuery(lat: unwrap.coordinate.latitude,
                                                                                       lon: unwrap.coordinate.longitude,
                                                                                       distanceMeter: kDefaultSearchNearMeDistance)).map {(title: kNearMeTitle, $0, zoomTo: unwrap.coordinate)}
            } else {
                return Single.create { single in
                    single(.success((title: nil, result: [], zoomTo: nil)))
                    return Disposables.create {}
                }
            }
        }
    }
    
    func resultByActionsObservable() -> Observable<(title: String?, result: [ActivityResult], zoomTo: CLLocationCoordinate2D?)> {
        return searchActions.throttle(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance).flatMapLatest {[weak self] (action) -> Observable<(title: String?, result: [ActivityResult], zoomTo: CLLocationCoordinate2D?)> in
            if let strongSelf = self {
                if action.isNearMeSearch {
                    return strongSelf.newNearMeSearchWith(config: HCLManager.shared).asObservable()
                } else {
                    return strongSelf.newSearchWith(config: HCLManager.shared,
                                                    address: action.address,
                                                    location: action.coordinate,
                                                    distance: action.distance,
                                                    country: action.country).asObservable()
                }
            } else {
                return Observable.create { (observer) -> Disposable in
                    observer.on(.next((title: nil, result: [], zoomTo: nil)))
                    return Disposables.create {}
                }
            }
            
        }
    }
}
