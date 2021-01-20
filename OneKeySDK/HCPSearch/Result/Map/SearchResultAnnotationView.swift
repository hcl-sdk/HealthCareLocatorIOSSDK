//
//  SearchResultAnnotationView.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import UIKit
import MapKit

class SearchResultAnnotationView: MKAnnotationView, ViewDesign {
    
    var markerImageView: UIImageView!
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupUI(icon: icons.mapMarkerIcon, color: theme.markerColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(icon: UIImage, color: UIColor) {
        frame = CGRect(x: 0, y: 0, width: 16.3, height: 23.3)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        collisionMode = .circle
        canShowCallout = true
        backgroundColor = .clear
        markerImageView = UIImageView(image: icon)
        markerImageView.tintColor = color
        markerImageView.frame = bounds
        markerImageView.contentMode = .scaleAspectFit
        addSubview(markerImageView)
    }
    
    func set(selected: Bool) {
        markerImageView.tintColor = selected ? theme.markerSelectedColor : theme.markerColor
    }
}
