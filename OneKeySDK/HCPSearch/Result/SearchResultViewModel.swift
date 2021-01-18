//
//  SearchResultViewModel.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/16/20.
//

import Foundation
import UIKit
import MapKit

class SearchResultViewModel: ViewLoading {
    lazy var indicator = UIActivityIndicatorView(style: .gray)
    
    private var webServices: SearchAPIsProtocol!
    private var search: SearchData!
    
    init(webservices: SearchAPIsProtocol, search: SearchData) {
        self.webServices = webservices
        self.search = search
    }
    
    // MARK: Searching
    func performSearch(config: OKSDKConfigure, completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        let info = GeneralQueryInput(first: 50,
                                     offset: 0,
                                     locale: config.lang,
                                     criteria: search.codes != nil ? nil : search.criteria)
        let userId = config.userId
        if search.isNearMeSearch == true {
            performNearMeSearchWith(info: info,
                                    userId: userId,
                                    completionHandler: completionHandler)
        } else if !search.address.orEmpty.isEmpty {
            performAddressSearchWith(address: search.address!,
                                     info: info,
                                     userId: userId,
                                     completionHandler: completionHandler)
        } else {
            fetchActivitiesWith(info: info,
                                specialties: search.codes?.map {$0.id},
                                location: nil,
                                county: "",
                                criteria: info.criteria,
                                userId: userId,
                                completionHandler: completionHandler)
        }
    }
    
    func performSearchWith(config: OKSDKConfigure,
                           coordinate: CLLocationCoordinate2D,
                           completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        let info = GeneralQueryInput(first: 50,
                                     offset: 0,
                                     locale: config.lang,
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
                // TODO: Handle error
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
    
    func layout(view: SearchResultViewController, theme: OKThemeConfigure) {
        view.resultsLabel.text = "onekey_sdk_results_label".localized
        view.listLabel.text = "onekey_sdk_list_label".localized
        view.mapLabel.text = "onekey_sdk_map_label".localized
        view.listIcon.image = UIImage.OKImageWith(name: "list-view")
        view.mapIcon.image = UIImage.OKImageWith(name: "map-view")

        // Fonts
        view.resultsLabel.font = theme.searchResultTotalFont
        view.criteriaLabel.font = theme.searchResultTitleFont
        view.addressLabel.font = theme.smallFont
        view.activityCountLabel.font = theme.smallFont
        view.topInputTextField.font = theme.searchInputFont
        
        // Colors
        view.resultsLabel.textColor = theme.darkColor
        view.sortButton.backgroundColor = theme.secondaryColor
        view.activityCountLabel.textColor = theme.primaryColor
        view.criteriaLabel.textColor = theme.darkColor
        view.addressLabel.textColor = theme.greyColor
        view.backButton.tintColor = theme.darkColor
        view.firstSeparatorView.backgroundColor = theme.greyLighterColor
        view.secondSeparatorView.backgroundColor = theme.greyLighterColor
        view.topInputTextField.textColor = theme.darkColor
        view.topInputTextField.attributedPlaceholder = NSAttributedString(string: "onekey_sdk_find_healthcare_professional".localized,
                                                                     attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        layout(view: view, theme: theme, mode: .list)
    }
    
    func layout(view: SearchResultViewController, theme: OKThemeConfigure, mode: SearchResultViewController.ViewMode) {
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
}
