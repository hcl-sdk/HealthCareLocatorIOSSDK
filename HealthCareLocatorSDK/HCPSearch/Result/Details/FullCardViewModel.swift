//
//  FullCardViewModel.swift
//  HealthCareLocatorSDK
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
                             config: HCLSDKConfigure,
                             completionHandler: @escaping ((Activity?, Error?) -> Void)) {
        webServices.fetchActivityWith(id: activityID,
                                      locale: config.lang.apiCode,
                                      userId: config.userId) { (activity, error) in
            completionHandler(activity, error)
        }
    }
    
    func layout(view: HCPFullCardViewController, with theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        DispatchQueue.main.async {
            
            view.mainInformationTitleLabel.text = "hcl_main_information_label".localized
            view.specialitiesTitleLabel.text = "hcl_specialities_label".localized
            view.specialitiesViewMoreLabel.text = "hcl_view_more".localized
            view.rateAndFundTitleLabel.text = "hcl_rate_refunds_label".localized
            view.informationTitleLabel.text = "hcl_information_label".localized
            view.questionLabel.text = "hcl_information_description".localized
            view.yesLabel.text = "hcl_information_yes_label".localized
            view.noLabel.text = "hcl_information_no_label".localized
            view.qualityTitleLabel.text = "hcl_improve_quality_label".localized
            view.editButtonTitleLabel.text = "hcl_suggess_modification_button".localized
            view.qualityDescriptionLabel.text = "hcl_improve_quality_text".localized
            
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
            
            // Icons
            view.markerIcon.image = icons.markerMinIcon
            view.phoneIcon.image = icons.phoneIcon
            view.faxIcon.image = icons.faxIcon
            view.websiteIcon.image = icons.websiteIcon
            view.yesIcon.image = icons.voteUpIcon
            view.noIcon.image = icons.voteDownIcon
            view.editIcon.image = icons.editIcon

            // Fonts
            view.drTitle.font = theme.profileTitleFont
            view.categoryTitle.font = theme.profileSubTitleFont
            view.editButtonTitleLabel.font = theme.buttonFont
            view.webUrlView.font = theme.defaultFont
            
            // Colors
            view.shareIcon.tintColor = theme.greyColor
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
            view.phoneIcon.tintColor = theme.greyColor
            view.faxIcon.tintColor = theme.greyColor
            view.websiteIcon.tintColor = theme.greyColor
        }
    }
    
    func layoutViewRating(view: HCPFullCardViewController, with theme: HCLThemeConfigure, value: Bool?) {
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
                
                addressComponent.append(activity.workplace.address.composedAddress)
                
                view.addressLabel.text = addressComponent.joined(separator: "\n")
                
                // Fill specialities label
                self.initSpecialtyDescription(view, specialties: activity.individual.specialties, showLess: true)
                
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
                    view.phoneViewWrapper.isHidden = true
                    view.phoneButton.isHidden = true
                }
                
                // Toggle fax component
                if !activity.fax.orEmpty.isEmpty {
                    view.faxLabel.text = activity.fax
                } else {
                    view.faxWrapper.isHidden = true
                }
                
                // Show / Hide contact wrapper
                
                if view.faxWrapper.isHidden && view.phoneViewWrapper.isHidden {
                    view.contactWrapper.isHidden = true
                }
                
                if view.contactWrapper.isHidden && view.websiteWrapper.isHidden {
                    view.web_contactWrapper.isHidden = true
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
    
    func suggestModification(apiKey: String, language: String, individualID: String) {
        let urlString = String(format: kModifyActivityURLFormat, language, apiKey, individualID)
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {return}
        UIApplication.shared.open(url)
    }
    
    func initSpecialtyDescription(_ view: HCPFullCardViewController, specialties: [KeyedString], showLess: Bool) {
        // init Value
        var specialties = specialties
        var listTag: [UIView] = []
        let maxWidth = UIScreen.main.bounds.size.width - 20 * 2
        var currentWidth: CGFloat = 0.0
        // init State
        view.specialitiesTitleLabel.text = "hcl_specialities_label".localized + (specialties.isEmpty ? "" : " (\(specialties.count))")
        view.specialitiesViewMoreView.isHidden = true
        view.specialitiesDescriptionStackView.arrangedSubviews.forEach { subview in
            view.specialitiesDescriptionStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        self.preconfigStackViewHeight(view, setDefault: specialties.isEmpty)
        // prepare data before create view
        if let searchCodes = view.searchCodes {
            specialties.sort { a, b in
                return searchCodes.contains(where: { $0.id == a.code })
            }
        }
        // add arrangedSubviews
        for item in specialties {
            let tag = self.createTagView(text: item.label, specialty: view.searchCodes?.contains(where: { $0.id == item.code }) ?? false)
            if currentWidth + (tag.size.width + 10) <= maxWidth {
                currentWidth += (tag.size.width + 10)
                listTag.append(tag.view)
            } else {
                view.specialitiesDescriptionStackView.addArrangedSubview(self.createStackView(listTag))
                if showLess && view.specialitiesDescriptionStackView.arrangedSubviews.count == 2 { // showLess: true - max 2 row, false - show all (next step)
                    view.specialitiesViewMoreView.isHidden = false
                    view.specialitiesDescriptionStackView.addArrangedSubview(view.specialitiesViewMoreView)
                    break
                } else { // reset list, width with current tag
                    listTag = [tag.view]
                    currentWidth = tag.size.width + 10
                }
            }
        }
        if !listTag.isEmpty {
            view.specialitiesDescriptionStackView.addArrangedSubview(self.createStackView(listTag))
        }
    }
    
    private func preconfigStackViewHeight(_ view: HCPFullCardViewController, setDefault: Bool) {
        if let _ = view.specialitiesDescriptionStackView_Height {
            view.specialitiesDescriptionStackView_Height.isActive = setDefault
        } else {
            guard setDefault else { return }
            view.specialitiesDescriptionStackView_Height = view.specialitiesDescriptionStackView.heightAnchor.constraint(equalToConstant: 0.0)
        }
    }
    
    private func createStackView(_ arrangedSubviews: [UIView]) -> UIStackView {
        let tempStack = UIStackView(arrangedSubviews: arrangedSubviews)
        tempStack.axis = .horizontal
        tempStack.spacing = 10.0
        return tempStack
    }
    
    private func createTagView(text: String, specialty: Bool) -> (view: UIView, size: CGSize) {
        let value: CGFloat = 10.0
        let label = UILabel()
        label.text = text
        label.textColor = specialty ? .white : .black
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.backgroundColor = specialty ? UIColor(red: 1.00, green: 0.55, blue: 0.16, alpha: 1.00) : .white
        view.layer.cornerRadius = 4.0
        if !specialty {
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor(red: 0.00, green: 0.64, blue: 0.87, alpha: 1.00).cgColor
        }
        view.addSubview(label)
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: value / 2).isActive = true
        NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: value).isActive = true
        return (view, CGSize(width: label.intrinsicContentSize.width + value * 2, height: label.intrinsicContentSize.height + value))
    }
}
