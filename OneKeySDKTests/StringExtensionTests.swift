//
//  StringExtensionTests.swift
//  OneKeySDKTests
//
//  Created by Truong Le on 12/29/20.
//

import XCTest
@testable import OneKeySDK

class StringExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStringExtension_WhenTranslationKeyLocalizedWithLanguageCode_WillReturnCorrectTranslatedText() {
        let key1 = "onekey_sdk_home_title"
        let key2 = "onekey_sdk_start_new_search"
        let key3 = "onekey_sdk_hcps_near_me"
        
        let translatedTextEn1 = key1.localized(lang: "en")
        let translatedTextEn2 = key2.localized(lang: "en")
        let translatedTextEn3 = key3.localized(lang: "en")
        
        let translatedTextFr1 = key1.localized(lang: "fr")
        let translatedTextFr2 = key2.localized(lang: "fr")
        let translatedTextFr3 = key3.localized(lang: "fr")
        
        XCTAssertEqual(translatedTextEn1, "Find and Locate\nHealthcare Professional", "Key '\(key1)' did not return correct translation value for English")
        XCTAssertEqual(translatedTextEn2, "Start a New Search", "Key '\(key2)' did not return correct translation value for English")
        XCTAssertEqual(translatedTextEn3, "HCPs near me", "Key '\(key3)' did not return correct translation value for English")
        XCTAssertEqual(translatedTextFr1, "Rechercher et Localiser\nProfessionnels de Santé", "Key '\(key1)' did not return correct translation value for French")
        XCTAssertEqual(translatedTextFr2, "Démarrer une nouvelle recherche", "Key '\(key1)' did not return correct translation value for French")
        XCTAssertEqual(translatedTextFr3, "HCPs près de moi", "Key '\(key1)' did not return correct translation value for French")
    }
}
