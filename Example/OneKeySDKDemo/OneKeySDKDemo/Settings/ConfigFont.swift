//
//  ConfigFont.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/16/20.
//

import Foundation
import RxSwift

class ConfigFont: NSObject {
    private let disposeBag = DisposeBag()
    
    private let fontName = PublishSubject<String>()
    private let fontSize = PublishSubject<CGFloat>()
    private let initFont = BehaviorSubject<UIFont?>(value: nil)
    
    override init() {
        super.init()
        // Font
        Observable.combineLatest(fontName, fontSize)
            .map {UIFont(name: $0.0,
                         size: $0.1)}
            .bind(to: initFont)
            .disposed(by: disposeBag)
        
    }
    
    func getFont() -> UIFont? {
        return (try? initFont.value())
    }
}

// MARK: Setters
extension ConfigFont {
    func initializeWith(font: UIFont) {
        fontName.onNext(font.fontName)
        fontSize.onNext(font.pointSize)
    }
    
    func set(size: CGFloat) {
        fontSize.onNext(size)
    }
    
    func set(name: String) {
        fontName.onNext(name)
    }
}

// MARK: Subscription
extension ConfigFont {
    var fontSizeAsString: Observable<String> {
        return fontSize.map {"\($0)"}
    }
    
    var customFont: Observable<UIFont?> {
        return initFont.asObservable()
    }
}
