//
//  HCPFullCardViewController.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/26/20.
//

import UIKit
import CoreLocation
import MapKit

class HCPFullCardViewController: UIViewController, ViewDesign {
    
    private let locationManager = CLLocationManager()
    let fullCardViewModel: FullCardViewModel! = FullCardViewModel(webServices: HCLHCPSearchWebServices(manager: HCLServiceManager.shared))
    var activityID: String?
    private var activity: Activity?
    
    // Wrapper
    @IBOutlet weak var contentWrapper: UIStackView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var phoneWrapper: UIStackView!
    @IBOutlet weak var faxWrapper: UIStackView!
    @IBOutlet weak var websiteWrapper: UIStackView!
    
    // General
    @IBOutlet weak var wrapperView: BaseView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareIcon: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var drTitle: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var placeMapView: MKMapView!
    
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var contentLabels: [UILabel]!
    @IBOutlet var lines: [UIView]!
    
    @IBOutlet weak var directionButton: BaseButton!
    @IBOutlet weak var phoneButton: BaseButton!
    @IBOutlet weak var selectedAddressWrapper: BaseView!
    @IBOutlet weak var selectedAddressLabel: UILabel!
    @IBOutlet weak var dropdownIcon: UIImageView!
    @IBOutlet weak var markerIcon: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var faxLabel: UILabel!
    
    // Main Information
    @IBOutlet weak var mainInformationTitleLabel: UILabel!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var faxIcon: UIImageView!
    @IBOutlet weak var websiteIcon: UIImageView!
    
    // Specialities
    @IBOutlet weak var specialitiesTitleLabel: UILabel!
    @IBOutlet weak var specialitiesDescriptionLabel: UILabel!
    
    // Rate and refunds
    @IBOutlet weak var rateAndRefundWrapper: UIStackView!
    @IBOutlet weak var rateAndFundTitleLabel: UILabel!
    @IBOutlet weak var rateAndFundDescriptionLabel: UILabel!
    @IBOutlet weak var rateAmountLabel: UILabel!
    
    // Information
    @IBOutlet weak var informationTitleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var yesBackground: BaseView!
    @IBOutlet weak var yesIcon: UIImageView!
    @IBOutlet weak var yesLabel: UILabel!
    
    @IBOutlet weak var noBackground: BaseView!
    @IBOutlet weak var noIcon: UIImageView!
    @IBOutlet weak var noLabel: UILabel!
    
    // Improve the data quality
    @IBOutlet weak var suggestEditWrapper: UIStackView!
    @IBOutlet weak var qualityTitleLabel: UILabel!
    @IBOutlet weak var qualityDescriptionLabel: UILabel!
    
    @IBOutlet weak var webUrlView: UITextView!
    @IBOutlet weak var editIcon: UIImageView!
    @IBOutlet weak var editButtonTitleLabel: UILabel!
    
    var rating: Bool? {
        didSet {
            layoutRatingWith(theme: theme, value: rating)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NOTE: Temporary disable rateAndRefund block as the service is not provided yet
        rateAndRefundWrapper.isHidden = true
        suggestEditWrapper.isHidden = !HCLManager.shared.isSuggestEditHCPEnable        
        contentWrapper.isHidden = true
        loadingView.isHidden = false
        loadingIndicator.startAnimating()
        
        placeMapView.delegate = self
        placeMapView.register(SearchResultAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

        if let id = activityID {
            fetchActivityWith(id: id)
            rating = AppConfigure.getVoteFor(activityId: id, by: AppConfigure.deviceId)
        } else {
            fatalError("Missing Activity ID")
        }
        
        layoutWith(theme: theme, icons: icons)
        
        fixWebURLViewDisplaying()
    }
    
    private func fixWebURLViewDisplaying() {
        webUrlView.textContainerInset = .zero
        webUrlView.textContainer.lineFragmentPadding = 0
    }
    
    private func animateContentDisplaying() {
        UIView.animate(withDuration: 0.2) { [unowned self] in
            self.loadingIndicator.stopAnimating()
            self.contentWrapper.isHidden = false
            self.loadingView.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    private func fetchActivityWith(id: String) {
        // Fetch activity
        fullCardViewModel.fetchActivityDetail(activityID: id, config: HCLManager.shared) {[weak self] (activity, error) in
            guard let strongSelf = self else {return}
            if let unwrapActivity = activity {
                // Save last HCPs consulted
                AppConfigure.save(activity: unwrapActivity)
                strongSelf.activity = unwrapActivity
                strongSelf.fullCardViewModel.fullFill(view: strongSelf, with: unwrapActivity)
                strongSelf.animateContentDisplaying()
            } else {
                // TODO: Handle error
            }
        }
    }
    
    func layoutWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        fullCardViewModel.layout(view: self, with: theme, icons: icons)
        fullCardViewModel.layoutViewRating(view: self, with: theme, value: rating)
    }
    
    
    // MARK: Actions
    @IBAction func onBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let items = [activity?.shareMessageWith(appName: HCLManager.shared.appName, and: HCLManager.shared.appDownloadLink) ?? ""] as [Any]
        let sharePanel = UIActivityViewController(activityItems: items, applicationActivities: nil)
        sharePanel.modalPresentationStyle = .overFullScreen
        present(sharePanel, animated: true, completion: nil)
    }
    
    @IBAction func directionAction(_ sender: Any) {
        if let location = locationManager.location,
           let activity = activity,
           let desLocation = activity.workplace.address.location {
            let userMark = MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate))
            userMark.name = "Your location"
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: desLocation.lat,
                                                                                                  longitude: desLocation.lon)))
            destination.name = activity.workplace.name
            Helper.openMapWithDirection(from: userMark,
                                        to: destination)
        }
    }
    
    @IBAction func phoneCallAction(_ sender: Any) {
        guard let phoneNumber = activity?.phone else {return}
        Helper.makeCallWith(phoneNumber: phoneNumber)
    }
    
    @IBAction func showMapAction(_ sender: Any) {
        performSegue(withIdentifier: "showMapView", sender: nil)
    }
    
    @IBAction func changeAddressAction(_ sender: Any) {
        performSegue(withIdentifier: "showAddressPicker", sender: activity)
    }
    
    @IBAction func modifyAction(_ sender: Any) {
        let manager = HCLManager.shared
        if let apiKey = manager.apiKey,
           let language = manager.lang,
           let individualID = activity?.individual.id {
            fullCardViewModel.suggestModification(apiKey: apiKey, language: language.code, individualID: individualID)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showAddressPicker":
                guard let addressPicker = segue.destination as? PickerListViewController,
                      let activity = sender as? Activity else {return}
                addressPicker.delegate = self
                let allActivities = activity.allActivities
                let selected = allActivities.firstIndex(where: { (other) -> Bool in
                    return other.id == activity.id
                 })
                
                addressPicker.configWith(items: allActivities.map {$0.workplace.address.composedAddress},
                                         selected: selected)
            case "showMapView":
                guard let mapVC = segue.destination as? HCPMapViewController else {return}
                mapVC.activity = activity
            default:
                return
            }
        }
    }

}

extension HCPFullCardViewController: PickerListViewControllerDelegate {
    func didSelect(item: String, at index: Int) {
        dismiss(animated: false) { [weak self] in
            guard let strongSelf = self,
                  let activityID = strongSelf.activity?.allActivities[index].id else {return}
            strongSelf.activityID = activityID
            strongSelf.fetchActivityWith(id: activityID)
        }
    }
    
    func backAction() {
        dismiss(animated: false, completion: nil)
    }

}

// MARK: Rating
extension HCPFullCardViewController {
    @IBAction func ratingYesAction(_ sender: Any) {
        rating = true
        AppConfigure.setVoteFor(activityId: activityID!, by: AppConfigure.deviceId, with: true)
    }
    
    @IBAction func ratingNoAction(_ sender: Any) {
        rating = false
        AppConfigure.setVoteFor(activityId: activityID!, by: AppConfigure.deviceId, with: false)
    }
    
    func layoutRatingWith(theme: HCLThemeConfigure, value: Bool?) {
        fullCardViewModel.layoutViewRating(view: self, with: theme, value: value)
    }
}

extension HCPFullCardViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
          return nil
        } else {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) {
                return annotationView
            } else {
                let annotationView = SearchResultAnnotationView(annotation: annotation,
                                                                reuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                annotationView.set(selected: true)
                return annotationView
            }
        }
    }
}
