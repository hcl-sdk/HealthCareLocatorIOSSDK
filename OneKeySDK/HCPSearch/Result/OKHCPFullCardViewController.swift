//
//  OKHCPFullCardViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/26/20.
//

import UIKit
import CoreLocation
import MapKit

class OKHCPFullCardViewController: UIViewController, OKViewDesign {
    private var selectedAddressIndex = 0
    private let mockAddresses = ["13 Rue Tronchet, 75008 Paris",
                                 "4 Rue Lincoln, 75008 Paris",
                                 "15 Rue de Surène, 75008 Paris",
                                 "43 Boulevard Malesherbes, 75008 Paris"]
    
    private let locationManager = CLLocationManager()
    
    var theme: OKThemeConfigure?
    var activity: Activity?
    
    // General
    @IBOutlet weak var wrapperView: OKBaseView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var drTitle: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var placeMapView: MKMapView!
    
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var contentLabels: [UILabel]!
    @IBOutlet var lines: [UIView]!
    
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
    
    @IBOutlet weak var yesBackground: OKBaseView!
    @IBOutlet weak var yesIcon: UIImageView!
    @IBOutlet weak var yesLabel: UILabel!
    
    @IBOutlet weak var noBackground: OKBaseView!
    @IBOutlet weak var noIcon: UIImageView!
    @IBOutlet weak var noLabel: UILabel!
    
    // Improve the data quality
    @IBOutlet weak var qualityTitleLabel: UILabel!
    @IBOutlet weak var qualityDescriptionLabel: UILabel!
    
    @IBOutlet weak var webUrlView: UITextView!
    @IBOutlet weak var editIcon: UIImageView!
    @IBOutlet weak var editButtonTitleLabel: UILabel!
    
    var rating: Bool? {
        didSet {
            guard let theme = theme else {
                return
            }
            layoutRatingWith(theme: theme, value: rating)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let theme = theme {
            layoutWith(theme: theme)
        }
        
        if let activity = activity {
            fullFill(activity: activity)
        }
        
        fixWebURLViewDisplaying()
    }
    
    private func fixWebURLViewDisplaying() {
        webUrlView.textContainerInset = .zero
        webUrlView.textContainer.lineFragmentPadding = 0
    }

    private func fullFill(activity: Activity) {
        drTitle.text = activity.title.label
        categoryTitle.text = activity.role.label
        webUrlView.text = activity.webAddress
        phoneLabel.text = activity.workplace.localPhone
        faxLabel.text = activity.workplace.localPhone
        selectedAddressLabel.text = "Address \(selectedAddressIndex + 1): \(mockAddresses[selectedAddressIndex])"
        // Map
        let activityCoordinate = CLLocationCoordinate2D(latitude: activity.workplace.address.location!.lat,
                                                        longitude: activity.workplace.address.location!.long)
        let anotation = MKPointAnnotation()
        anotation.coordinate = activityCoordinate
        placeMapView.addAnnotation(anotation)
        placeMapView.setCamera(MKMapCamera(lookingAtCenter: activityCoordinate,
                                           fromDistance: 8000,
                                           pitch: 0,
                                           heading: 0),
                               animated: false)
    }
    
    func layoutWith(theme: OKThemeConfigure) {
        for titleLabel in titleLabels {
            titleLabel.textColor = theme.secondaryColor
            titleLabel.font = theme.profileTitleSectionFont
        }
        
        for contentLabel in contentLabels {
            contentLabel.font = theme.defaultFont
            contentLabel.textColor = theme.darkColor
        }
        
        for line in lines {
            line.backgroundColor = theme.greyLighterColor
        }
        
        // Fonts
        drTitle.font = theme.profileTitleFont
        categoryTitle.font = theme.profileSubTitleFont
        editButtonTitleLabel.font = theme.buttonFont
        webUrlView.font = theme.defaultFont
        
        // Colors
        wrapperView.borderColor = theme.cardBorderColor
        webUrlView.textColor = theme.darkColor
        webUrlView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: theme.darkColor!, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        drTitle.textColor = theme.secondaryColor
        categoryTitle.textColor = theme.darkColor
        phoneButton.tintColor = theme.secondaryColor
        directionButton.tintColor = theme.secondaryColor
        editIcon.tintColor = theme.secondaryColor
        markerIcon.tintColor = theme.markerColor
        
        layoutRatingWith(theme: theme, value: rating)
    }
    
    
    // MARK: Actions
    @IBAction func onBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func directionAction(_ sender: Any) {
        if let location = locationManager.location,
           let activity = activity,
           let desLocation = activity.workplace.address.location {
            let userMark = MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate))
            userMark.name = "Your location"
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: desLocation.lat,
                                                                                                  longitude: desLocation.long)))
            destination.name = activity.title.label
            Helper.openMapWithDirection(from: userMark,
                                        to: destination)
        }
    }
    
    @IBAction func phoneCallAction(_ sender: Any) {
        guard let phoneNumber = activity?.workplace.localPhone else {return}
        Helper.makeCallWith(phoneNumber: phoneNumber)
    }
    
    @IBAction func changeAddressAction(_ sender: Any) {
        performSegue(withIdentifier: "showAddressPicker", sender: selectedAddressIndex)
    }
    
    @IBAction func modifyAction(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.ekino.vn")!, options: [:], completionHandler: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showAddressPicker":
                guard let addressPicker = segue.destination as? PickerListViewController else {return}
                addressPicker.delegate = self
                addressPicker.configWith(theme: theme, items: mockAddresses, selected: selectedAddressIndex)
            default:
                return
            }
        }
    }

}

extension OKHCPFullCardViewController: PickerListViewControllerDelegate {
    func didSelect(item: String, at index: Int) {
        dismiss(animated: false) {
            self.selectedAddressLabel.text = "Address \(index + 1): \(self.mockAddresses[index])"
            self.selectedAddressIndex = index
        }
    }
    
    func backAction() {
        dismiss(animated: false, completion: nil)
    }

}

// MARK: Rating
extension OKHCPFullCardViewController {
    @IBAction func ratingYesAction(_ sender: Any) {
        rating = true
    }
    
    @IBAction func ratingNoAction(_ sender: Any) {
        rating = false
    }
    
    func layoutRatingWith(theme: OKThemeConfigure, value: Bool?) {
        yesLabel.textColor = theme.darkColor
        noLabel.textColor = theme.darkColor
        yesBackground.borderColor = theme.greyLightColor
        noBackground.borderColor = theme.greyLightColor
        if let rating = rating {
            if rating {
                yesBackground.backgroundColor = theme.voteUpColor
                noBackground.backgroundColor = .white
                yesIcon.tintColor = .white
                noIcon.tintColor = theme.greyLightColor
            } else {
                yesBackground.backgroundColor = .white
                noBackground.backgroundColor = theme.voteDownColor
                yesIcon.tintColor = theme.greyLightColor
                noIcon.tintColor = .white
            }
        } else {
            yesIcon.tintColor = theme.greyLightColor
            noIcon.tintColor = theme.greyLightColor
        }
    }
}
