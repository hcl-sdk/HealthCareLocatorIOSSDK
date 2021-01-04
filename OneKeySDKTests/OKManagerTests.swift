//
//  OKManagerTests.swift
//  OneKeySDKTests
//
//  Created by Truong Le on 12/30/20.
//

import XCTest
@testable import OneKeySDK

class OKManagerTests: XCTestCase {

    let manager = OKManager.shared
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialize_WithAllParamsProvided_HandlerShouldBeCalledWithSuccessStateTrue() {
        // Arrange
        let mockAPIKey = "an_api_key"
        let mockConfig = OKSearchConfigure(entry: .home, favourites: [])
        let expected = expectation(description: "Callback has has been call with success state is true")
        
        // Act
        manager.initialize(apiKey: mockAPIKey, configure: mockConfig) { (success, error) in
            XCTAssertTrue(success, "Expected initialize callback called with success is 'true' but receive 'false'")
            expected.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout error: \(error)")
            }
        }
    }
    
    func testInitialize_WithWrongParamsProvided_HandlerShouldBeCalledWithSuccessStateFalse() {
        // Arrange
        let mockAPIKey = "an_api_key"
        let mockConfig = OKSearchConfigure(entry: .home, favourites: ["SP.1", "SP.2"])
        let expected = expectation(description: "Callback has has been call with success state is false")
        
        // Act
        manager.initialize(apiKey: mockAPIKey, configure: mockConfig) { (success, error) in
            XCTAssertFalse(success, "Expected initialize callback called with success is 'false' but receive 'true'")
            expected.fulfill()
        }
        
        // Assert
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout error: \(error)")
            }
        }
    }

    func testInitialize_WithoutCallbackProvided_ShouldNoExceptionThrow() {
        let mockAPIKey = "an_api_key"
        let mockConfig = OKSearchConfigure(entry: .home, favourites: ["SP.1", "SP.2"])
        manager.initialize(apiKey: mockAPIKey, configure: mockConfig)
        XCTAssertNoThrow("Expected initialize does not throw an exception if no callback provided")
    }
    
    func testInitialize_WithOnlyAPIKeyProvided_ShouldNoExceptionThrow() {
        let mockAPIKey = "an_api_key"
        let mockConfig = OKSearchConfigure(entry: .home, favourites: ["SP.1", "SP.2"])
        manager.initialize(apiKey: mockAPIKey, configure: mockConfig)
        XCTAssertNoThrow("Expected initialize does not throw an exception if no callback provided")
    }
    
    func testSetUserId_WithSpecificStringProvided_ManagerShouldRecordUserId() {
        let mockUserId = "an_user_id"
        manager.set(userId: mockUserId)
        XCTAssertEqual(mockUserId, manager.userId, "Expected the user id is stored after set but received a different user id")
    }
    
    func testSetSearchConfig_WithEmptyConfigObjectProvided_ManagerShouldRecordTheSearchConfig() {
        let searchConfig = OKSearchConfigure()
        manager.configure(search: searchConfig)
        XCTAssertEqual(manager.searchConfigure?.entry, .home, "Expected the configure entry is stored after set but received a different configured entry")
        XCTAssertEqual(manager.searchConfigure?.favourites, [], "Expected the configure specialities is stored after set but received a different configured specialities")

    }
    
    func testSetSearchConfig_WithSpecificConfigObjectProvided_ManagerShouldRecordTheSearchConfig() {
        let mockEntry = OKSearchConfigure.SearchEntry.nearMe
        let mockSpeciaialities = ["SP.1", "SP.2"]
        let searchConfig = OKSearchConfigure(entry: mockEntry, favourites: mockSpeciaialities)
        manager.configure(search: searchConfig)
        XCTAssertEqual(manager.searchConfigure?.entry, mockEntry, "Expected the configure entry is stored after set but received a different configured entry")
        XCTAssertEqual(manager.searchConfigure?.favourites, mockSpeciaialities, "Expected the configure specialities is stored after set but received a different configured specialities")
    }
    
    func testSetLocale_WithSpecificStringProvided_ManagerShouldRecordLanguage() {
        let mockLanguage = "fr"
        manager.setLocale(lang: mockLanguage)
        XCTAssertEqual(mockLanguage, manager.lang, "Expected the language code is stored after set but received a different language code")
    }
    
    func testGetDefaultSearchConfigure_ManagerShouldReturnCorrectDefaultSearchConfiguretionObject() {
        let defaultConfig = manager.getDefaultSearchConfigure()
        let emptyConfig = OKSearchConfigure()
        XCTAssertEqual(defaultConfig.entry, emptyConfig.entry, "Expected the default config entry is equal with the initial config without params entry but received a different entry value")
        XCTAssertEqual(defaultConfig.favourites, emptyConfig.favourites, "Expected the default config favourites is equal with the initial config without params favourites but received a different entry value")
    }
    func testGetefaultUIConfigure_ManagerShouldReturnCorrectDefaultThemeConfiguretionObject() {}
    func testHCPSearchViewController_WithFullModeIsTrue_AndEntryIsHome_ManagerShouldReturnNavigationViewControllerWithSearchHomeFullViewControllerIsRootView() {}
    func testHCPSearchViewController_WithFullModeIsFalse_AndEntryIsHome_ManagerShouldReturnNavigationViewControllerWithSearchHomeViewControllerIsRootView() {}
    func testHCPSearchViewController_WithFullModeIsTrue_AndEntryIsNearme_ManagerShouldReturnNavigationViewControllerWithSearchResultViewControllerIsRootView() {}
    func testHCPSearchViewController_WithFullModeIsFalse_AndEntryIsNearme_ManagerShouldReturnNavigationViewControllerWithSearchResultViewControllerIsRootView() {}
    func testSearchNearMe_WithNoUILoaded_ShouldReturnFalse() {}
}
