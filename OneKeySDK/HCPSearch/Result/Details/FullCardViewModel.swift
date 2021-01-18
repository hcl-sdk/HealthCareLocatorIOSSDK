//
//  FullCardViewModel.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/17/20.
//

import Foundation
import MapKit

class FullCardViewModel {
    let webServices: SearchAPIsProtocol!
    
    init(webServices: SearchAPIsProtocol) {
        self.webServices = webServices
    }
    
    func fetchActivityDetail(activityID: String,
                             config: OKSDKConfigure,
                             completionHandler: @escaping ((Activity?, Error?) -> Void)) {
        webServices.fetchActivityWith(id: activityID,
                                      locale: config.lang,
                                      userId: config.userId) { (activity, error) in
            completionHandler(activity, error)
        }
    }
    
    func layout(view: HCPFullCardViewController, with theme: OKThemeConfigure) {
        DispatchQueue.main.async {
            
            view.mainInformationTitleLabel.text = "onekey_sdk_main_information_label".localized
            view.specialitiesTitleLabel.text = "onekey_sdk_specialities_label".localized
            view.rateAndFundTitleLabel.text = "onekey_sdk_rate_refunds_label".localized
            view.informationTitleLabel.text = "onekey_sdk_information_label".localized
            view.questionLabel.text = "onekey_sdk_information_description".localized
            view.yesLabel.text = "onekey_sdk_information_yes_label".localized
            view.noLabel.text = "onekey_sdk_information_no_label".localized
            view.qualityTitleLabel.text = "onekey_sdk_improve_quality_label".localized
            view.editButtonTitleLabel.text = "onekey_sdk_suggess_modification_button".localized
            
            for titleLabel in view.titleLabels {
                titleLabel.textColor = theme.secondaryColor
                titleLabel.font = theme.profileTitleSectionFont
            }
            
            for contentLabel in view.contentLabels {
                contentLabel.font = theme.defaultFont
                contentLabel.textColor = theme.darkColor
            }
            
            for line in view.lines {
                line.backgroundColor = theme.greyLighterColor
            }
            
            // Fonts
            view.drTitle.font = theme.profileTitleFont
            view.categoryTitle.font = theme.profileSubTitleFont
            view.editButtonTitleLabel.font = theme.buttonFont
            view.webUrlView.font = theme.defaultFont
            
            // Colors
            view.wrapperView.borderColor = theme.cardBorderColor
            view.webUrlView.textColor = theme.darkColor
            view.webUrlView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: theme.darkColor!, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            view.drTitle.textColor = theme.secondaryColor
            view.categoryTitle.textColor = theme.darkColor
            view.phoneButton.tintColor = theme.secondaryColor
            view.phoneButton.borderColor = theme.buttonBorderColor
            view.directionButton.tintColor = theme.secondaryColor
            view.directionButton.borderColor = theme.buttonBorderColor
            view.selectedAddressWrapper.borderColor = theme.buttonBorderColor
            view.editIcon.tintColor = theme.secondaryColor
            view.markerIcon.tintColor = theme.markerColor
        }
    }
    
    func layoutViewRating(view: HCPFullCardViewController, with theme: OKThemeConfigure, value: Bool?) {
        DispatchQueue.main.async {
            view.yesLabel.textColor = theme.darkColor
            view.noLabel.textColor = theme.darkColor
            view.yesBackground.borderColor = theme.greyLightColor
            view.noBackground.borderColor = theme.greyLightColor
            if let rating = value {
                if rating {
                    view.yesBackground.backgroundColor = theme.voteUpColor
                    view.noBackground.backgroundColor = .white
                    view.yesIcon.tintColor = .white
                    view.noIcon.tintColor = theme.greyLightColor
                } else {
                    view.yesBackground.backgroundColor = .white
                    view.noBackground.backgroundColor = theme.voteDownColor
                    view.yesIcon.tintColor = theme.greyLightColor
                    view.noIcon.tintColor = .white
                }
            } else {
                view.yesIcon.tintColor = theme.greyLightColor
                view.noIcon.tintColor = theme.greyLightColor
            }
        }
    }
    
    func fullFill(view: HCPFullCardViewController, with activity: Activity) {
        if view.isViewLoaded {
            DispatchQueue.main.async {
                view.drTitle.text = activity.individual.composedName
                view.categoryTitle.text = activity.individual.professionalType?.label
                
                view.selectedAddressWrapper.isHidden = activity.individual.otherActivities.count < 1
                
                // Fill address label
                view.selectedAddressLabel.text = activity.workplace.address.composedAddress
                
                var addressComponent: [String] = []
                if let name = activity.workplace.name, !name.isEmpty {
                    addressComponent.append(name)
                }
                
                if let buildingLabel = activity.workplace.address.buildingLabel, !buildingLabel.isEmpty {
                    addressComponent.append(buildingLabel)
                }
                
                if let address = activity.workplace.address.longLabel, !address.isEmpty {
                    addressComponent.append(address)
                }
                
                view.addressLabel.text = addressComponent.joined(separator: "\n")
                
                // Fill specialities label
                view.specialitiesDescriptionLabel.text = activity.individual.specialties.compactMap {$0.label.isEmpty ? nil : $0.label  }.joined(separator: ", ")
                
                // Toggle web component
                if !activity.webAddress.orEmpty.isEmpty {
                    view.webUrlView.text = activity.webAddress
                } else {
                    view.websiteWrapper.isHidden = true
                }
                
                // Toggle phone component
                if !activity.phone.orEmpty.isEmpty {
                    view.phoneLabel.text = activity.phone
                } else {
                    view.phoneWrapper.isHidden = true
                }
                
                // Toggle fax component
                if !activity.fax.orEmpty.isEmpty {
                    view.faxLabel.text = activity.fax
                } else {
                    view.faxWrapper.isHidden = true
                }
                
                // Map
                let activityCoordinate = CLLocationCoordinate2D(latitude: activity.workplace.address.location!.lat,
                                                                longitude: activity.workplace.address.location!.lon)
                let anotation = MKPointAnnotation()
                anotation.coordinate = activityCoordinate
                view.placeMapView.removeAnnotations(view.placeMapView.annotations)
                view.placeMapView.addAnnotation(anotation)
                view.placeMapView.setCamera(MKMapCamera(lookingAtCenter: activityCoordinate,
                                                        fromDistance: kDefaultZoomLevel,
                                                        pitch: 0,
                                                        heading: 0),
                                            animated: false)
                // Dismiss loading view
                view.loadingView.isHidden = true
                view.contentWrapper.isHidden = false
                
            }
        }
    }
}
