//
//  ConfigFont.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/16/20.
//

import Foundation
import RxSwift

class ConfigFont: NSObject {
    private let disposeBag = DisposeBag()
    
    private let fontFamily = PublishSubject<FontMapping>()
    private let fontStyle = PublishSubject<FontStyles>()
    private let fontSize = PublishSubject<CGFloat>()
    private let initFont = BehaviorSubject<UIFont?>(value: nil)
    
    override init() {
        super.init()
        // Font
        Observable.combineLatest(fontFamily.distinctUntilChanged(),
                                 fontStyle.distinctUntilChanged(),
                                 fontSize.distinctUntilChanged())
            .map({ (family, style, size) -> UIFont? in
                switch style {
                case .Regular:
                    return UIFont(name: family.regularFontName, size: size)
                case .Bold:
                    return UIFont(name: family.boldFontName, size: size)
                case .Italic:
                    return UIFont(name: family.italicFontName, size: size)
                case .BoldItalic:
                    return UIFont(name: family.boldItalicFontName, size: size)
                }
            })
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
        if let mapping = FontMapping.from(familyName: font.familyName) {
            fontFamily.onNext(mapping)
            switch font.fontName {
            case mapping.regularFontName:
                fontStyle.onNext(.Regular)
            case mapping.boldFontName:
                fontStyle.onNext(.Bold)
            case mapping.italicFontName:
                fontStyle.onNext(.Italic)
            case mapping.boldItalicFontName:
                fontStyle.onNext(.BoldItalic)
            default:
                break
            }
            fontSize.onNext(font.pointSize)
        }
        
    }
    
    func set(size: CGFloat) {
        fontSize.onNext(size)
    }
    
    func set(family: FontMapping) {
        fontFamily.onNext(family)
    }
    
    func set(style: FontStyles) {
        fontStyle.onNext(style)
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
    
    var fontFamilyNameObservable: Observable<String> {
        return fontFamily.map {$0.fontFamily}
    }
    
    var fontStyleAsStringObservable: Observable<String> {
        return fontStyle.map {$0.title}
    }
}
