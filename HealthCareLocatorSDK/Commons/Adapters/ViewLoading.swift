//
//  ViewLoading.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/22/20.
//

import Foundation
import UIKit

protocol ViewLoading {
    var indicator: UIActivityIndicatorView { get }
    func showLoadingOn(view: UIView)
    func hideLoading()
}

extension ViewLoading {
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
