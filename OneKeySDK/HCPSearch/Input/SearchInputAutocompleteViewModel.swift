//
//  SearchInputAutocompleteModelView.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/15/20.
//

import Foundation
import RxSwift
import CoreLocation

class SearchInputAutocompleteViewModel {
    let disposeBag = DisposeBag()
    let webServices: OKHCPSearchWebServices!
    
    let autocompleteCreteriaSubject = PublishSubject<String>()
    private let isLoadingCodes = PublishSubject<Bool>()
    private let isLoadingIndividuals = PublishSubject<Bool>()

    private(set) var creteria: String?
    private(set) var selectedCode: Code?
    private(set) var address: String?
    private(set) var isNearMeSearch: Bool = false
    
    init(webServices: OKHCPSearchWebServices) {
        self.webServices = webServices
    }
    
    func codesByLabelObservableWith(creteria: String) -> Observable<[Code]> {
        return Observable.create {[weak self] (observer) -> Disposable in
            if creteria.isEmpty {
                observer.onNext([])
                observer.onCompleted()
            } else {
                if let webservice = self?.webServices {
                    self?.isLoadingCodes.onNext(true)
                    webservice.fetchCodesByLabel(info: GeneralQueryInput(apiKey: "1",
                                                                         first: 5,
                                                                         offset: 0,
                                                                         userId: "1",
                                                                         locale: "en"),
                                                 criteria: creteria,
                                                 codeTypes: ["SP"],
                                                 manager: OKServiceManager.shared) { (codes, error) in
                        if let error = error {
                            observer.onError(error)
                        } else {
                            observer.onNext(codes ?? [])
                        }
                        self?.isLoadingCodes.onNext(false)
                        observer.onCompleted()
                    }
                } else {
                    observer.onNext([])
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    func individualsByNameObservableWith(creteria: String) -> Observable<[IndividualWorkPlaceDetails]> {
        return Observable.create {[weak self] (observer) -> Disposable in
            if creteria.isEmpty {
                observer.onNext([])
                observer.onCompleted()
            } else {
                if let webservice = self?.webServices {
                    self?.isLoadingIndividuals.onNext(true)
                    webservice.fetchIndividualsByNameWith(info: GeneralQueryInput(apiKey: "1",
                                                                                  first: 5,
                                                                                  offset: 0,
                                                                                  userId: "1",
                                                                                  locale: "en"),
                                                          county: "",
                                                          criteria: creteria,
                                                          manager: OKServiceManager.shared) { (individuals, error) in
                        if let error = error {
                            observer.onError(error)
                        } else {
                            observer.onNext(individuals ?? [])
                        }
                        self?.isLoadingIndividuals.onNext(false)
                        observer.onCompleted()
                    }
                } else {
                    observer.onNext([])
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}

extension SearchInputAutocompleteViewModel {
    func codesObservable() -> Observable<[Code]> {
        return autocompleteCreteriaSubject.filter {$0.count != 1 && $0.count != 2}.flatMapLatest { [unowned self] in codesByLabelObservableWith(creteria: $0)}
    }
    
    func individualsObservable() -> Observable<[IndividualWorkPlaceDetails]> {
        return autocompleteCreteriaSubject.filter {$0.count != 1 && $0.count != 2}.flatMapLatest { [unowned self] in individualsByNameObservableWith(creteria: $0)}
    }
    
    func isFirstFieldLoading() -> Observable<Bool> {
        return Observable.combineLatest(isLoadingCodes, isLoadingIndividuals).map {$0.0 || $0.1}
    }
}

extension SearchInputAutocompleteViewModel {
    func set(data: OKHCPSearchData) {
        set(isNearMeSearch: (data.isNearMeSearch == true || data.isQuickNearMeSearch == true))
    }
    
    func set(criteria: String) {
        self.creteria = criteria
        self.selectedCode = nil
    }
    
    func set(code: Code) {
        self.creteria = nil
        self.selectedCode = code
    }
    
    func set(address: String) {
        self.address = address
        self.isNearMeSearch = false
    }
    
    func set(isNearMeSearch: Bool) {
        self.isNearMeSearch = isNearMeSearch
    }
}
