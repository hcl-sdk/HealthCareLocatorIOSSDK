//
//  SearchInputAutocompleteModelView.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 12/15/20.
//

import Foundation
import RxSwift
import CoreLocation

class SearchInputAutocompleteViewModel {
    let disposeBag = DisposeBag()
    let webServices: HCLHCPSearchWebServices!
    
    let autocompleteCreteriaSubject = PublishSubject<String>()
    private let isLoadingCodes = PublishSubject<Bool>()
    private let isLoadingIndividuals = PublishSubject<Bool>()

    private(set) var creteria: String?
    private(set) var selectedCode: Code?
    private(set) var address: String?
    private(set) var isNearMeSearch: Bool = false
    
    init(webServices: HCLHCPSearchWebServices) {
        self.webServices = webServices
    }
    
    func codesByLabelObservableWith(creteria: String, userId: String?, language: String? = "en") -> Observable<[Code]> {
        return Observable.create {[weak self] (observer) -> Disposable in
            if creteria.isEmpty {
                observer.onNext([])
                observer.onCompleted()
            } else {
                if let webservice = self?.webServices {
                    self?.isLoadingCodes.onNext(true)
                    webservice.fetchCodesByLabel(info: GeneralQueryInput(first: 5,
                                                                         offset: 0,
                                                                         locale: language),
                                                 criteria: creteria,
                                                 codeTypes: kSupportedCodeTypes,
                                                 userId: userId) { (codes, error) in
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
    
    func individualsByNameObservableWith(creteria: String, userId: String?, language: String? = "en") -> Observable<[IndividualWorkPlaceDetails]> {
        return Observable.create {[weak self] (observer) -> Disposable in
            if creteria.isEmpty {
                observer.onNext([])
                observer.onCompleted()
            } else {
                if let webservice = self?.webServices {
                    self?.isLoadingIndividuals.onNext(true)
                    webservice.fetchIndividualsByNameWith(info: GeneralQueryInput(first: 5,
                                                                                  offset: 0,
                                                                                  locale: language),
                                                          county: "",
                                                          criteria: creteria,
                                                          userId: userId) { (individuals, error) in
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
    func codesObservable(config: HCLSDKConfigure) -> Observable<[Code]> {
        return autocompleteCreteriaSubject.filter {$0.count != 1 && $0.count != 2}.flatMapLatest { [unowned self] in codesByLabelObservableWith(creteria: $0, userId: config.userId, language: config.lang.apiCode)}
    }
    
    func individualsObservable(config: HCLSDKConfigure) -> Observable<[IndividualWorkPlaceDetails]> {
        return autocompleteCreteriaSubject.filter {$0.count != 1 && $0.count != 2}.flatMapLatest { [unowned self] in individualsByNameObservableWith(creteria: $0, userId: config.userId, language: config.lang.apiCode)}
    }
    
    func isFirstFieldLoading() -> Observable<Bool> {
        return Observable.combineLatest(isLoadingCodes, isLoadingIndividuals).map {$0.0 || $0.1}
    }
}

extension SearchInputAutocompleteViewModel {
    func set(data: SearchData) {
        set(isNearMeSearch: data.isNearMeSearch)
    }
    
    func set(criteria: String?) {
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
    
    func isSelectedCode() -> Bool {
        return selectedCode != nil
    }
}
