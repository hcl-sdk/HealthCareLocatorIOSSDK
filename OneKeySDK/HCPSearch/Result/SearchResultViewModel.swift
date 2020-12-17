//
//  SearchResultViewModel.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/16/20.
//

import Foundation
import UIKit

class SearchResultViewModel {
    private var indicator = UIActivityIndicatorView(style: .gray)
    
    private var webServices: OKHCPSearchWebServicesProtocol!
    private var search: OKHCPSearchData!
    
    init(webservices: OKHCPSearchWebServicesProtocol, search: OKHCPSearchData) {
        self.webServices = webservices
        self.search = search
    }
    
    func performSearch(_ completionHandler: @escaping (([ActivityResult]?, Error?) -> Void)) {
        let info = GeneralQueryInput(apiKey: "1",
                                     first: 50,
                                     offset: 0,
                                     userId: nil,
                                     locale: "en",
                                     criteria: search.code != nil ? nil : search.criteria)

        webServices.fetchActivitiesWith(info: info,
                                        specialties: search.code != nil ? [search.code!.id] : nil,
                                        location: GeopointQuery(lat: 43.76438020602678,
                                                                lon: -79.31803766618543), // Temporary for now
                                        county: "",
                                        criteria: info.criteria,
                                        manager: OKServiceManager.shared) { (result, error) in
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
