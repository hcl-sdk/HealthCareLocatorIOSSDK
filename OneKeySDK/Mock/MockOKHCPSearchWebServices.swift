//
//  MockOKHCPSearchWebServices.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/10/20.
//

import Foundation

class MockOKHCPSearchWebServices: OKHCPSearchWebServicesProtocol {
    func searchHCPWith(input: OKHCPSearchInput, manager: OKServiceManager, completionHandler: @escaping (([Activity]?, OKError?) -> Void)) {
        completionHandler(getMockSearchResult(), nil)
    }
    
    private func getMockSearchResult() -> [Activity] {
        return [Activity(id: "id_1",
                         title: ActivityTitle(label: "Dr William Dahan"),
                         role: ActivityRole(label: "General practitioner"),
                         phone: "+84975565801",
                         fax: "84975565801",
                         webAddress: "https://www.ekino.vn",
                         workplace: Activity.Workplace(id: "id_1",
                                                       name: "General practitioner",
                                                       localPhone: "+33975565802",
                                                       address: Activity.Workplace.Address(longLabel: "13 Rue Tronchet, 75008 Paris",
                                                                                           city: Activity.Workplace.Address.City(label: ""),
                                                                                           country: Activity.Workplace.Address.Country(label: ""),
                                                                                           postalCode: "75008",
                                                                                           location: Activity.Workplace.Address.Location(lat: 48.882213,
                                                                                                                                         long: 2.321886)))),
                Activity(id: "id_2",
                                 title: ActivityTitle(label: "Dr Hababou Danielle"),
                                 role: ActivityRole(label: "General practitioner"),
                                 phone: "+84975565801",
                                 fax: "84975565801",
                                 webAddress: "https://www.ekino.vn",
                                 workplace: Activity.Workplace(id: "id_1",
                                                               name: "General practitioner",
                                                               localPhone: "+33975565802",
                                                               address: Activity.Workplace.Address(longLabel: "4 Rue Lincoln, 75008 Paris",
                                                                                                   city: Activity.Workplace.Address.City(label: ""),
                                                                                                   country: Activity.Workplace.Address.Country(label: ""),
                                                                                                   postalCode: "75008",
                                                                                                   location: Activity.Workplace.Address.Location(lat: 48.888338,
                                                                                                                                                 long: 2.288830)))),
                Activity(id: "id_3",
                                 title: ActivityTitle(label: "Dr Geraldine Grauzman Rebot"),
                                 role: ActivityRole(label: "General practitioner"),
                                 phone: "+84975565801",
                                 fax: "84975565801",
                                 webAddress: "https://www.ekino.vn",
                                 workplace: Activity.Workplace(id: "id_1",
                                                               name: "General practitioner",
                                                               localPhone: "+33975565802",
                                                               address: Activity.Workplace.Address(longLabel: "15 Rue de Surène, 75008 Paris",
                                                                                                   city: Activity.Workplace.Address.City(label: ""),
                                                                                                   country: Activity.Workplace.Address.Country(label: ""),
                                                                                                   postalCode: "75008",
                                                                                                   location: Activity.Workplace.Address.Location(lat: 48.829548,
                                                                                                                                                 long: 2.282515)))),
                Activity(id: "id_4",
                                 title: ActivityTitle(label: "Dr Boksenbaum Michel"),
                                 role: ActivityRole(label: "General practitioner"),
                                 phone: "+84975565801",
                                 fax: "84975565801",
                                 webAddress: "https://www.ekino.vn",
                                 workplace: Activity.Workplace(id: "id_1",
                                                               name: "General practitioner",
                                                               localPhone: "+33975565802",
                                                               address: Activity.Workplace.Address(longLabel: "43 Boulevard Malesherbes, 75008 Paris",
                                                                                                   city: Activity.Workplace.Address.City(label: ""),
                                                                                                   country: Activity.Workplace.Address.Country(label: ""),
                                                                                                   postalCode: "75008",
                                                                                                   location: Activity.Workplace.Address.Location(lat: 48.834700,
                                                                                                                                                 long: 2.332315))))]
    }
}
