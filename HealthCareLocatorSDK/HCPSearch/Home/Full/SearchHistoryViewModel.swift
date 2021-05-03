//
//  SearchHistoryViewModel.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/30/20.
//

import Foundation
import CoreLocation
import RxSwift

enum HistorySection: Equatable {
    static func == (lhs: HistorySection, rhs: HistorySection) -> Bool {
        switch lhs {
        case .nearMe:
            switch rhs {
            case .lastSearchs, .lasHCPConsolted:
                return false
            case .nearMe:
                return true
            }
        case .lastSearchs:
            switch rhs {
            case .nearMe, .lasHCPConsolted:
                return false
            case .lastSearchs:
                return true
            }
        case .lasHCPConsolted:
            switch rhs {
            case .nearMe, .lastSearchs:
                return false
            case .lasHCPConsolted:
                return true
            }
        }
    }
    
    case nearMe(title: String, activities: [ActivityResult])
    case lastSearchs(title: String, searches: [LastSearch])
    case lasHCPConsolted(title: String, activities: [LastHCPConsulted])
    
    var title: String {
        switch self {
        case .nearMe(let title, _):
            return title
        case .lastSearchs(let title, _):
            return title
        case .lasHCPConsolted(let title, _):
            return title
        }
    }
}

class SearchHistoryViewModel: ViewLoading {
    lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    var webService: SearchAPIsProtocol!
    
    init(webService: SearchAPIsProtocol) {
        self.webService = webService
    }
    
    func fetchHistory(config: HCLSDKConfigure, lastSearches: [LastSearch], lastHCPs: [LastHCPConsulted]) -> Single<[HistorySection]> {
        return getCurrentLocation().flatMap {[weak self] (coordinate) -> Single<[ActivityResult]> in
            guard let strongSelf = self else {
                return Single.create { single in
                    single(.error(HCLError.noResult))
                    return Disposables.create {}
                }
            }
            if let coordinate = coordinate {
                let manager = HCLServiceManager.shared
                let location = GeopointQuery(lat: coordinate.latitude,
                                             lon: coordinate.longitude,
                                             distanceMeter: kDefaultSearchNearMeDistance)
                let query = GeneralQueryInput(first: 50,
                                              offset: 0,
                                              locale: config.lang.apiCode,
                                              criteria: nil)
                let userId = config.userId
                return strongSelf.fetchActivitiesWith(info: query,
                                                      location: location,
                                                      webService: strongSelf.webService,
                                                      manager: manager,
                                                      userId: userId)
            } else {
                return Single.create { single in
                    single(.success([]))
                    return Disposables.create {}
                }
            }
        }.map { (activities) -> [HistorySection] in
            return [HistorySection.nearMe(title: "hcl_hcps_near_me".localized, activities: activities),
                    HistorySection.lastSearchs(title: "hcl_last_searches".localized, searches: lastSearches),
                    HistorySection.lasHCPConsolted(title: "hcl_last_hcps_consulted".localized, activities: lastHCPs)]
        }
    }
    
    private func getCurrentLocation() -> Single<CLLocationCoordinate2D?> {
        return Single<CLLocationCoordinate2D?>.create { single in
            LocationManager.shared.requestLocation { (locations, error) in
                single(.success(locations?.last?.coordinate))
//                if let location = locations?.last?.coordinate {
//                    single(.success(location))
//                } else if let error = error {
//                    single(.error(error))
//                } else {
//                    single(.error(HCLError.noResult))
//                }
            }
            return Disposables.create {}
        }
    }
    
    private func fetchActivitiesWith(info: GeneralQueryInput,
                                     location: GeopointQuery,
                                     webService: SearchAPIsProtocol,
                                     manager: HCLServiceManager,
                                     userId: String?) -> Single<[ActivityResult]> {
        return Single<[ActivityResult]>.create { single in
            webService.fetchActivitiesWith(info: info,
                                           specialties: nil,
                                           location: location,
                                           county: nil,
                                           criteria: nil,
                                           userId: userId) { (result, error) in
                if let result = result {
                    single(.success(result))
                } else if let error = error {
                    single(.error(error))
                } else {
                    single(.success([]))
                }
            }
            return Disposables.create {}
        }
    }
}
