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
    
    private func performNearMeSearchWith(info: GeneralQueryInput,
                                         userId: String?,
                                         completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        LocationManager.shared.requestLocation {[weak self] (locations, error) in
            guard let strongSelf = self else {return}
            if let lastLocation = locations?.last {
                strongSelf.fetchActivitiesWith(info: info,
                                               specialties: strongSelf.search.codes?.map {$0.id},
                                               location: GeopointQuery(lat: 43.76438020602678,
                                                                       lon: -79.31803766618543),
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
                                        userId: userId) {[weak self] (result, error) in
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
    func sortResultBy(_ sort: SearchResultSortViewController.SortBy, _ completionHandler: ((SearchData) -> Void)) {
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
}
