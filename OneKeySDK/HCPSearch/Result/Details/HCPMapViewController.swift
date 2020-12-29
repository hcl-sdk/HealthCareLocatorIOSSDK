//
//  HCPMapViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/23/20.
//

import UIKit
import MapKit

class HCPMapViewController: UIViewController, ViewDesign {
    var theme: OKThemeConfigure?
    var activity: Activity?
    
    private let viewModel = HCPMapViewModel()
    
    @IBOutlet weak var markerIcon: UIImageView!
    @IBOutlet weak var workplaceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var mapWrapper: BaseView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentLocationButton: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let theme = theme {
            layoutWith(theme: theme)
        }
        
        if let activity = activity {
            layoutWith(activity: activity)
        }
    }
    
    func layoutWith(theme: OKThemeConfigure) {
        viewModel.layout(view: self, with: theme)
    }
    
    func layoutWith(activity: Activity) {
        viewModel.layout(view: self, with: activity)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func currentLocationAction(_ sender: Any) {
        viewModel.moveMapToCurrentLocation(map: mapView)
    }
}
