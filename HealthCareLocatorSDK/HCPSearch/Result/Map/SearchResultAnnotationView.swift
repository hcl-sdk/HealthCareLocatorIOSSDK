//
//  SearchResultAnnotationView.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/10/20.
//

import UIKit
import MapKit

class SearchResultAnnotationView: MKAnnotationView, ViewDesign {
    
    var markerImageView: UIImageView!
    var countingView: UIView!
    var countingLabel: UILabel!

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
        
        // Add counting for the marker with same address
        let countingFrame = CGRect(x: 0, y: 0, width: 16.3, height: 16.3)
        countingView = UIView(frame: countingFrame)
        countingView.backgroundColor = .white
        countingView.layer.cornerRadius = 16.3/2
        countingView.layer.borderWidth = 2
        countingView.layer.borderColor = theme.markerColor.cgColor
        countingView.clipsToBounds = true
        
        countingLabel = UILabel(frame: CGRect(x: 3, y: 1, width: countingFrame.width - 6, height: countingFrame.height - 4))
        countingLabel.adjustsFontSizeToFitWidth = true
        countingLabel.minimumScaleFactor = 0.5
        countingLabel.textAlignment = .center
        countingLabel.font = theme.smallFont
        countingLabel.textColor = theme.darkColor
        countingView.addSubview(countingLabel)
        
        // The couting is hidden by default, only display it if there is more than 1 result at the same coordinate, this action should be decide outside of this view
        countingView.isHidden = true
        addSubview(countingView)
    }
    
    func set(counting: Int) {
        countingView.isHidden = counting <= 1
        countingLabel.text = "\(counting)"
    }
    
    func set(selected: Bool) {
        let color = selected ? theme.markerSelectedColor : theme.markerColor
        markerImageView.tintColor = color
        countingView.layer.borderColor = color?.cgColor
    }
}
