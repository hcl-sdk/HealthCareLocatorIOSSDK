//
//  SearchResultAnnotationView.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import UIKit
import MapKit

class SearchResultAnnotationView: MKMarkerAnnotationView {
    static let preferredClusteringIdentifier = Bundle.main.bundleIdentifier! + ".SearchResultAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = SearchResultAnnotationView.preferredClusteringIdentifier
        collisionMode = .circle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
