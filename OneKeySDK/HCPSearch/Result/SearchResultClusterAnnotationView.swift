//
//  SearchResultClusterAnnotationView.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import UIKit
import MapKit

class SearchResultClusterAnnotationView: MKAnnotationView {
    static let preferredClusteringIdentifier = Bundle.main.bundleIdentifier! + ".SearchResultClusterAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
