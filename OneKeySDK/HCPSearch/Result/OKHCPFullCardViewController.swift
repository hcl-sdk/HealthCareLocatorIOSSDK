//
//  OKHCPFullCardViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/26/20.
//

import UIKit
import MapKit

class OKHCPFullCardViewController: UIViewController, OKViewDesign {
    var theme: OKThemeConfigure?

    // General
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var drTitle: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var placeMapView: MKMapView!
    
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var contentLabels: [UILabel]!
    
    
    @IBOutlet weak var directionButton: OKBaseButton!
    @IBOutlet weak var phoneButton: OKBaseButton!
    @IBOutlet weak var selectedAddressLabel: UILabel!
    @IBOutlet weak var dropdownIcon: UIImageView!
    @IBOutlet weak var markerIcon: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var faxLabel: UILabel!
    
    // Main Information
    @IBOutlet weak var mainInformationTitleLabel: UILabel!
    
    // Specialities
    @IBOutlet weak var specialitiesTitleLabel: UILabel!
    @IBOutlet weak var specialitiesDescriptionLabel: UILabel!
    
    // Rate and refunds
    @IBOutlet weak var rateAndFundTitleLabel: UILabel!
    @IBOutlet weak var rateAndFundDescriptionLabel: UILabel!
    @IBOutlet weak var rateAmountLabel: UILabel!
    
    // Information
    @IBOutlet weak var informationTitleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    
    // Improve the data quality
    @IBOutlet weak var qualityTitleLabel: UILabel!
    @IBOutlet weak var qualityDescriptionLabel: UILabel!
    
    @IBOutlet weak var webUrlView: UITextView!
    @IBOutlet weak var editIcon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let theme = theme {
            layoutWith(theme: theme)
        }
        
        fixWebURLViewDisplaying()
    }
    
    private func fixWebURLViewDisplaying() {
        webUrlView.textContainerInset = .zero
        webUrlView.textContainer.lineFragmentPadding = 0
        webUrlView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
    }

    func layoutWith(theme: OKThemeConfigure) {
        for titleLabel in titleLabels {
            titleLabel.textColor = theme.secondaryColor
            titleLabel.font = theme.titleFont
        }
        
        for contentLabel in contentLabels {
            contentLabel.font = theme.defaultFont
        }
        
        phoneButton.tintColor = theme.secondaryColor
        directionButton.tintColor = theme.secondaryColor
        editIcon.tintColor = theme.secondaryColor
        markerIcon.tintColor = theme.markerColor
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
