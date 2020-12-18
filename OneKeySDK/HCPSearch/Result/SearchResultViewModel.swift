//
//  SearchResultViewModel.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/16/20.
//

import Foundation
import UIKit
import MapKit

class SearchResultViewModel {
    private var indicator = UIActivityIndicatorView(style: .gray)
    
    private var webServices: OKHCPSearchWebServicesProtocol!
    private var search: OKHCPSearchData!
    
    init(webservices: OKHCPSearchWebServicesProtocol, search: OKHCPSearchData) {
        self.webServices = webservices
        self.search = search
    }
    
    // MARK: Searching
    func performSearch(_ completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        let info = GeneralQueryInput(apiKey: "1",
                                     first: 50,
                                     offset: 0,
                                     userId: nil,
                                     locale: "en",
                                     criteria: search.code != nil ? nil : search.criteria)
        
        if search.isNearMeSearch == true {
            performNearMeSearchWith(info: info,
                                    completionHandler: completionHandler)
        } else if !search.address.orEmpty.isEmpty {
            performAddressSearchWith(address: search.address!,
                                     info: info,
                                     completionHandler: completionHandler)
        } else {
            fetchActivitiesWith(info: info,
                                specialties: search.code != nil ? [search.code!.id] : nil,
                                location: nil,
                                county: "",
                                criteria: info.criteria,
                                manager: OKServiceManager.shared,
                                completionHandler: completionHandler)
        }
    }
    
    private func performNearMeSearchWith(info: GeneralQueryInput, completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        OKLocationManager.shared.requestLocation {[weak self] (locations) in
            guard let strongSelf = self else {return}
            if let lastLocation = locations.last {
                strongSelf.fetchActivitiesWith(info: info,
                                    specialties: strongSelf.search.code != nil ? [strongSelf.search.code!.id] : nil,
                                    location: GeopointQuery(lat: 43.76438020602678,
                                                            lon: -79.31803766618543),
                                    county: "",
                                    criteria: info.criteria,
                                    manager: OKServiceManager.shared,
                                    completionHandler: completionHandler)
            } else {
                // TODO: Handle error
            }
        }
    }
    
    private func performAddressSearchWith(address: String, info: GeneralQueryInput, completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        CLGeocoder().geocodeAddressString(address) {[weak self]  (placeMarks, error) in
            guard let strongSelf = self else {return}
            if let location = placeMarks?.first?.location {
                strongSelf.fetchActivitiesWith(info: info,
                                               specialties: strongSelf.search.code != nil ? [strongSelf.search.code!.id] : nil,
                                               location: GeopointQuery(lat: location.coordinate.latitude,
                                                                       lon: location.coordinate.longitude),
                                               county: "",
                                               criteria: info.criteria,
                                               manager: OKServiceManager.shared,
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
                                     manager: OKServiceManager,
                                     completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        webServices.fetchActivitiesWith(info: info,
                                        specialties: specialties,
                                        location: location,
                                        county: county,
                                        criteria: criteria,
                                        manager: OKServiceManager.shared) {[weak self] (result, error) in
            if let unwrapResult = result {
                self?.search.change(result: unwrapResult)
                completionHandler(unwrapResult, nil)
            } else {
                self?.search.change(result: [])
                if let error = error {
                    completionHandler(nil, error)
                } else {
                    completionHandler([], nil)
                }
            }
        }
    }
    
    // MARK: Sorting
    func sortResultBy(_ sort: OKHCPSearchResultSortViewController.SortBy, _ completionHandler: ((OKHCPSearchData) -> Void)) {
        switch sort {
        case .name:
            search.result.sort { (lhs, rhs) -> Bool in
                return lhs.activity.individual.lastName < rhs.activity.individual.lastName
            }
        case .distance:
            search.result.sort { (lhs, rhs) -> Bool in
                return lhs.distance ?? 0 < rhs.distance ?? 0
            }
        case .relevance:
            search.result.sort { (lhs, rhs) -> Bool in
                return lhs.relevance ?? 0 < rhs.relevance ?? 0
            }
        }
        completionHandler(search)
    }
    
    func showLoadingOn(view: UIView) {
        if indicator.superview != nil {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
        
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([NSLayoutConstraint(item: indicator, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
                             NSLayoutConstraint(item: indicator, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)])
        indicator.startAnimating()
    }
    
    func hideLoading() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
}
