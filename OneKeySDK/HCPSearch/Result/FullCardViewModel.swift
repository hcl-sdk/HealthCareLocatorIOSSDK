//
//  FullCardViewModel.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/17/20.
//

import Foundation
import MapKit

class FullCardViewModel {
    let activityID: String!
    let webServices: OKHCPSearchWebServicesProtocol!
    
    init(activityID: String, webServices: OKHCPSearchWebServicesProtocol) {
        self.activityID = activityID
        self.webServices = webServices
    }
    
    func fetchActivityDetail(_ completionHandler: @escaping ((Activity?, Error?) -> Void)) {
        webServices.fetchActivityWith(apiKey: "1",
                                      userId: nil,
                                      id: activityID,
                                      locale: "en",
                                      manager: OKServiceManager.shared) { (activity, error) in
            completionHandler(activity, error)
        }
    }
    
    func fullFill(view: OKHCPFullCardViewController, with activity: Activity) {
        if view.isViewLoaded {
            DispatchQueue.main.async {
                view.drTitle.text = activity.individual.composedName
                view.categoryTitle.text = activity.individual.professionalType?.label
                
                // Fill address label
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
