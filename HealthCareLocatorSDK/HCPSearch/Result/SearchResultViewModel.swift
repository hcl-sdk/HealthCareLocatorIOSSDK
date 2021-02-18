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
        let info = GeneralQueryInput(first: 50,
                                     offset: 0,
                                     locale: config.lang.apiCode,
                                     criteria: search.codes != nil ? nil : search.criteria)
        let userId = config.userId
        switch search.mode {
        case .nearMeSearch,
             .quickNearMeSearch:
            performNearMeSearchWith(info: info,
                                    userId: userId,
                                    completionHandler: completionHandler)
        case .addressSearch(let address):
            performAddressSearchWith(address: address,
                                     info: info,
                                     userId: userId,
                                     completionHandler: completionHandler)
        default:
            fetchActivitiesWith(info: info,
                                specialties: search.codes?.map {$0.id},
                                location: nil,
                                county: "",
                                criteria: info.criteria,
                                userId: userId,
                                completionHandler: completionHandler)
        }
    }
    
    func performSearchWith(config: HCLSDKConfigure,
                           coordinate: CLLocationCoordinate2D,
                           completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        let info = GeneralQueryInput(first: 50,
                                     offset: 0,
                                     locale: config.lang.apiCode,
                                     criteria: search.codes != nil ? nil : search.criteria)
        fetchActivitiesWith(info: info,
                            specialties: search.codes?.map {$0.id},
                            location: GeopointQuery(lat: coordinate.latitude,
                                                    lon: coordinate.longitude),
                            county: "",
                            criteria: info.criteria,
                            userId: config.userId,
                            completionHandler: completionHandler)
    }
    
    
    private func performNearMeSearchWith(info: GeneralQueryInput,
                                         userId: String?,
                                         completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        LocationManager.shared.requestLocation {[weak self] (locations, error) in
            guard let strongSelf = self else {return}
            if let lastLocation = locations?.last {
                strongSelf.fetchActivitiesWith(info: info,
                                               specialties: strongSelf.search.codes?.map {$0.id},
                                               location: GeopointQuery(lat: lastLocation.coordinate.latitude,
                                                                       lon: lastLocation.coordinate.longitude),
                                               county: "",
                                               criteria: info.criteria,
                                               userId: userId,
                                               completionHandler: completionHandler)
            } else {
                // TODO: Handle error
            }
        }
    }
    
    private func performAddressSearchWith(address: String,
                                          info: GeneralQueryInput,
                                          userId: String?,
                                          completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        CLGeocoder().geocodeAddressString(address) {[weak self]  (placeMarks, error) in
            guard let strongSelf = self else {return}
            if let location = placeMarks?.first?.location {
                strongSelf.fetchActivitiesWith(info: info,
                                               specialties: strongSelf.search.codes?.map {$0.id},
                                               location: GeopointQuery(lat: location.coordinate.latitude,
                                                                       lon: location.coordinate.longitude),
                                               county: "",
                                               criteria: info.criteria,
                                               userId: userId,
                                               completionHandler: completionHandler)
            } else {
                print(error)
                // Can not detect location
                completionHandler([], nil)
            }
        }
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
        view.criteriaLabel.text = searchData.codes?.first?.longLbl ?? searchData.criteria ?? " "
        switch searchData.mode {
        case .baseSearch:
            view.topInputWrapper.isHidden = false
            view.topLabelsWrapper.isHidden = true
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
        let coordinate: CLLocationCoordinate2D?
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
    
    private func searchWith(config: HCLSDKConfigure, coordinate: CLLocationCoordinate2D) -> Single<[ActivityResult]> {
        return Single.create {[weak self] single in
            if let strongSelf = self {
                strongSelf.performSearchWith(config: config, coordinate: coordinate,
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
    
    func newSearchWith(config: HCLSDKConfigure, location: CLLocationCoordinate2D) -> Single<(title: String?, result: [ActivityResult], zoomTo: CLLocationCoordinate2D?)> {
        return Single.zip(reverseGeocodeLocation(location: CLLocation(latitude: location.latitude,
                                                                      longitude: location.longitude)),
                          searchWith(config: config, coordinate: location)).map {(title: $0.0, result: $0.1, zoomTo: nil)}
    }
    
    func newNearMeSearchWith(config: HCLSDKConfigure) -> Single<(title: String?, result: [ActivityResult], zoomTo: CLLocationCoordinate2D?)> {
        return requestCurrentLocation().flatMap {[weak self] (location) -> Single<(title: String?, result: [ActivityResult], zoomTo: CLLocationCoordinate2D?)> in
            if let strongSelf = self, let unwrap = location {
                return strongSelf.searchWith(config: config, coordinate: unwrap.coordinate).map {(title: kNearMeTitle, $0, zoomTo: unwrap.coordinate)}
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
                                                    location: action.coordinate!).asObservable()
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
