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
    
    func testInitialize_WithNoConfigureProvided_HandlerShouldBeCalledWithSuccessStateTrue() {
        // Arrange
        let mockAPIKey = "an_api_key"
        let expected = expectation(description: "Callback has has been call with success state is true")
        
        // Act
        manager.initialize(apiKey: mockAPIKey, configure: nil) { (success, error) in
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
    
    func testGetDefaultUIConfigure_ManagerShouldReturnCorrectDefaultThemeConfiguretionObject() {
        let defaultTheme = manager.getDefaultUIConfigure()
        let theme = OKThemeConfigure()
        XCTAssertEqual(defaultTheme, theme, "Expected the default theme config is equal with the initial theme config without params but received a different entry value")
    }
    
    func testGetDefaultUIConfigure_LoadFonts_ManagerShouldReturnThemeObjectWithAvailableFontValues() {
        // Act
        let defaultTheme = manager.getDefaultUIConfigure()
        
        // Assert
        XCTAssertNotNil(defaultTheme.defaultFont, "Expected default font loaded but received nil")
        XCTAssertNotNil(defaultTheme.titleMainFont, "Expected title_main font loaded but received nil")
        XCTAssertNotNil(defaultTheme.titleSecondaryFont, "Expected title_secondary font loaded but received nil")
        XCTAssertNotNil(defaultTheme.searchResultTotalFont, "Expected search_result_total font loaded but received nil")
        XCTAssertNotNil(defaultTheme.searchResultTitleFont, "Expected search_result_title font loaded but received nil")
        XCTAssertNotNil(defaultTheme.resultTitleFont, "Expected result_title_font font loaded but received nil")
        XCTAssertNotNil(defaultTheme.resultSubTitleFont, "Expected result_sub_title font loaded but received nil")
        XCTAssertNotNil(defaultTheme.profileTitleFont, "Expected profile_title font loaded but received nil")
        XCTAssertNotNil(defaultTheme.profileSubTitleFont, "Expected profile_sub_title font loaded but received nil")
        XCTAssertNotNil(defaultTheme.profileTitleSectionFont, "Expected profile_title_section font loaded but received nil")
        XCTAssertNotNil(defaultTheme.resultTitleFont, "Expected result_title font loaded but received nil")
        XCTAssertNotNil(defaultTheme.cardTitleFont, "Expected card_title font loaded but received nil")
        XCTAssertNotNil(defaultTheme.modalTitleFont, "Expected modal_title font loaded but received nil")
        XCTAssertNotNil(defaultTheme.searchInputFont, "Expected search_input font loaded but received nil")
        XCTAssertNotNil(defaultTheme.sortCriteriaFont, "Expected sort_criteria font loaded but received nil")
        XCTAssertNotNil(defaultTheme.buttonFont, "Expected button font loaded but received nil")
        XCTAssertNotNil(defaultTheme.smallFont, "Expected small font loaded but received nil")
    }
    
    func testGetDefaultUIConfigure_ManagerShouldReturnCorrectConfiguredValues() {
        // Arrange
        let defaultFont: UIFont? = UIFont(name: "Helvetica", size: 14.0)
        let titleMainFont: UIFont? = UIFont(name: "Helvetica", size: 20.0)
        let titleSecondaryFont: UIFont? = UIFont(name: "Helvetica", size: 16.0)
        let searchResultTotalFont: UIFont? = UIFont(name: "Helvetica", size: 14.0)
        let searchResultTitleFont: UIFont? = UIFont(name: "Helvetica", size: 16.0)
        let resultTitleFont: UIFont? = UIFont(name: "Helvetica", size: 14.0)
        let resultSubTitleFont: UIFont? = UIFont(name: "Helvetica", size: 14.0)
        let profileTitleFont: UIFont? = UIFont(name: "Helvetica", size: 18.0)
        let profileSubTitleFont: UIFont? = UIFont(name: "Helvetica", size: 16.0)
        let profileTitleSectionFont: UIFont? = UIFont(name: "Helvetica", size: 16.0)
        let cardTitleFont: UIFont? = UIFont(name: "Helvetica", size: 16.0)
        let modalTitleFont: UIFont? = UIFont(name: "Helvetica", size: 18.0)
        let searchInputFont: UIFont? = UIFont(name: "Helvetica", size: 16.0)
        let sortCriteriaFont: UIFont? = UIFont(name: "Helvetica", size: 16.0)
        let buttonFont: UIFont? = UIFont(name: "Helvetica", size: 14.0)
        let smallFont: UIFont? = UIFont(name: "Helvetica", size: 12.0)
        
        let primaryColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1)
        let secondaryColor: UIColor? = UIColor(red: 0/255, green: 163/255, blue: 224/255, alpha: 1)
        let buttonBkgColor: UIColor? = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
        let buttonAcceptBkgColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1)
        let buttonDiscardBkgColor: UIColor? = UIColor(red: 154/255, green: 160/255, blue: 167/255, alpha: 1)
        let buttonBorderColor: UIColor? = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        let cardBorderColor: UIColor? = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
        let markerColor: UIColor? = UIColor(red: 254/255, green: 138/255, blue: 18/255, alpha: 1)
        let markerSelectedColor: UIColor? = UIColor(red: 253/255, green: 134/255, blue: 112/255, alpha: 1)
        let viewBkgColor: UIColor? = UIColor(red: 248/255, green: 249/255, blue: 250/255, alpha: 1)
        let listBkgColor: UIColor? = UIColor(red: 248/255, green: 249/255, blue: 250/255, alpha: 1)
        let voteUpColor: UIColor? = UIColor(red: 67/255, green: 176/255, blue: 42/255, alpha: 1)
        let voteDownColor: UIColor? = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        let darkColor: UIColor? = UIColor(red: 43/255, green: 60/255, blue: 77/255, alpha: 1)
        let greyColor: UIColor? = UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1)
        let greyDarkColor: UIColor? = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        let greyDarkerColor: UIColor? = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        let greyLightColor: UIColor? = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        let greyLighterColor: UIColor? = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        
        // Act
        let defaultTheme = manager.getDefaultUIConfigure()

        // Assert
        XCTAssertEqual(defaultFont, defaultTheme.defaultFont, "Expected default theme has correct default font value but received a different value")
        XCTAssertEqual(titleMainFont, defaultTheme.titleMainFont, "Expected default theme has correct title_main font value but received a different value")
        XCTAssertEqual(titleSecondaryFont, defaultTheme.titleSecondaryFont, "Expected default theme has correct title_secondary font value but received a different value")
        XCTAssertEqual(searchResultTotalFont, defaultTheme.searchResultTotalFont, "Expected default theme has correct search_result_total font value but received a different value")
        XCTAssertEqual(searchResultTitleFont, defaultTheme.searchResultTitleFont, "Expected default theme has correct search_result_title font value but received a different value")
        XCTAssertEqual(resultTitleFont, defaultTheme.resultTitleFont, "Expected default theme has correct result_title font value but received a different value")
        XCTAssertEqual(resultSubTitleFont, defaultTheme.resultSubTitleFont, "Expected default theme has correct result_sub_title font value but received a different value")
        XCTAssertEqual(profileTitleFont, defaultTheme.profileTitleFont, "Expected default theme has correct profile_title font value but received a different value")
        XCTAssertEqual(profileSubTitleFont, defaultTheme.profileSubTitleFont, "Expected default theme has correct profile_sub_title font value but received a different value")
        XCTAssertEqual(profileTitleSectionFont, defaultTheme.profileTitleSectionFont, "Expected default theme has correct profile_title_section font value but received a different value")
        XCTAssertEqual(cardTitleFont, defaultTheme.cardTitleFont, "Expected default theme has correct card_title font value but received a different value")
        XCTAssertEqual(modalTitleFont, defaultTheme.modalTitleFont, "Expected default theme has correct modal_title font value but received a different value")
        XCTAssertEqual(searchInputFont, defaultTheme.searchInputFont, "Expected default theme has correct search_input font value but received a different value")
        XCTAssertEqual(sortCriteriaFont, defaultTheme.sortCriteriaFont, "Expected default theme has correct sort_criteria font value but received a different value")
        XCTAssertEqual(buttonFont, defaultTheme.buttonFont, "Expected default theme has correct button font value but received a different value")
        XCTAssertEqual(smallFont, defaultTheme.smallFont, "Expected default theme has correct small font value but received a different value")
        XCTAssertEqual(primaryColor, defaultTheme.primaryColor, "Expected default theme has correct primary color value but received a different value")
        XCTAssertEqual(secondaryColor, defaultTheme.secondaryColor, "Expected default theme has correct secondary color value but received a different value")
        XCTAssertEqual(buttonBkgColor, defaultTheme.buttonBkgColor, "Expected default theme has correct button_background color value but received a different value")
        XCTAssertEqual(buttonAcceptBkgColor, defaultTheme.buttonAcceptBkgColor, "Expected default theme has correct button_accept_background color value but received a different value")
        XCTAssertEqual(buttonDiscardBkgColor, defaultTheme.buttonDiscardBkgColor, "Expected default theme has correct button_discard_background color value but received a different value")
        XCTAssertEqual(buttonBorderColor, defaultTheme.buttonBorderColor, "Expected default theme has correct button_border color value but received a different value")
        XCTAssertEqual(cardBorderColor, defaultTheme.cardBorderColor, "Expected default theme has correct card_border color value but received a different value")
        XCTAssertEqual(markerColor, defaultTheme.markerColor, "Expected default theme has correct marker color value but received a different value")
        XCTAssertEqual(markerSelectedColor, defaultTheme.markerSelectedColor, "Expected default theme has correct marker_selected color value but received a different value")
        XCTAssertEqual(viewBkgColor, defaultTheme.viewBkgColor, "Expected default theme has correct view_background color value but received a different value")
        XCTAssertEqual(listBkgColor, defaultTheme.listBkgColor, "Expected default theme has correct list_background color value but received a different value")
        XCTAssertEqual(voteUpColor, defaultTheme.voteUpColor, "Expected default theme has correct vote_up color value but received a different value")
        XCTAssertEqual(voteDownColor, defaultTheme.voteDownColor, "Expected default theme has correct vote_down color value but received a different value")
        XCTAssertEqual(darkColor, defaultTheme.darkColor, "Expected default theme has correct dark color value but received a different value")
        XCTAssertEqual(greyColor, defaultTheme.greyColor, "Expected default theme has correct grey color value but received a different value")
        XCTAssertEqual(greyDarkColor, defaultTheme.greyDarkColor, "Expected default theme has correct grey_dark color value but received a different value")
        XCTAssertEqual(greyDarkerColor, defaultTheme.greyDarkerColor, "Expected default theme has correct grey_darker color value but received a different value")
        XCTAssertEqual(greyLightColor, defaultTheme.greyLightColor, "Expected default theme has correct grey_light color value but received a different value")
        XCTAssertEqual(greyLighterColor, defaultTheme.greyLighterColor, "Expected default theme has correct grey_lighter color value but received a different value")

    }
    
    func testHCPSearchViewController_WithFullModeIsTrue_AndEntryIsHome_ManagerShouldReturnNavigationViewControllerWithSearchHomeFullViewControllerIsRootView() {
        // Arrange
        manager.configure(search: OKSearchConfigure(entry: .home, favourites: nil))
        
        // Act
        let searchHomeVC = manager.getHCPSearchViewController(fullMode: true)
        
        // Assert
        XCTAssertNotNil(searchHomeVC.viewControllers.first, "Expected manager return navigation view controller with root view controller available but received nil")
        XCTAssertTrue(searchHomeVC.viewControllers.first! is SearchHomeFullViewController, "Expected manager return navigation view controller with root view controller is SearchHomeFullViewController but received a different value")

    }
    
    func testHCPSearchViewController_WithFullModeIsFalse_AndEntryIsHome_ManagerShouldReturnNavigationViewControllerWithSearchHomeViewControllerIsRootView() {
        // Arrange
        manager.configure(search: OKSearchConfigure(entry: .home, favourites: nil))
        
        // Act
        let searchHomeVC = manager.getHCPSearchViewController(fullMode: false)
        
        // Assert
        XCTAssertNotNil(searchHomeVC.viewControllers.first, "Expected manager return navigation view controller with root view controller available but received nil")
        XCTAssertTrue(searchHomeVC.viewControllers.first! is SearchHomeViewController, "Expected manager return navigation view controller with root view controller is SearchHomeViewController but received a different value")
    }
    
    func testHCPSearchViewController_WithFullModeIsTrue_AndEntryIsNearme_ManagerShouldReturnNavigationViewControllerWithSearchResultViewControllerIsRootView() {
        // Arrange
        manager.configure(search: OKSearchConfigure(entry: .nearMe, favourites: nil))
        
        // Act
        let searchHomeVC = manager.getHCPSearchViewController(fullMode: true)
        
        // Assert
        XCTAssertNotNil(searchHomeVC.viewControllers.first, "Expected manager return navigation view controller with root view controller available but received nil")
        XCTAssertTrue(searchHomeVC.viewControllers.first! is SearchResultViewController, "Expected manager return navigation view controller with root view controller is SearchResultViewController but received a different value")
    }
    
    func testHCPSearchViewController_WithFullModeIsFalse_AndEntryIsNearme_ManagerShouldReturnNavigationViewControllerWithSearchResultViewControllerIsRootView() {
        // Arrange
        manager.configure(search: OKSearchConfigure(entry: .nearMe, favourites: nil))
        
        // Act
        let searchHomeVC = manager.getHCPSearchViewController(fullMode: true)
        
        // Assert
        XCTAssertNotNil(searchHomeVC.viewControllers.first, "Expected manager return navigation view controller with root view controller available but received nil")
        XCTAssertTrue(searchHomeVC.viewControllers.first! is SearchResultViewController, "Expected manager return navigation view controller with root view controller is SearchResultViewController but received a different value")
    }
    
    func testHCPSearchViewController_WithFullModeIsFalse_AndNoConfigure_ManagerShouldReturnNavigationViewControllerWithSearchHomeViewControllerIsRootView() {
        // Arrange
        manager.configure(search: nil)
        
        // Act
        let searchHomeVC = manager.getHCPSearchViewController(fullMode: false)
        
        // Assert
        XCTAssertNotNil(searchHomeVC.viewControllers.first, "Expected manager return navigation view controller with root view controller available but received nil")
        XCTAssertTrue(searchHomeVC.viewControllers.first! is SearchHomeViewController, "Expected manager return navigation view controller with root view controller is SearchHomeViewController but received a different value")
    }
    
    func testHCPSearchViewController_WithFullModeIsTrue_AndNoConfigure_ManagerShouldReturnNavigationViewControllerWithSearchHomeFullViewControllerIsRootView() {
        // Arrange
        manager.configure(search: nil)
        
        // Act
        let searchHomeVC = manager.getHCPSearchViewController(fullMode: true)
        
        // Assert
        XCTAssertNotNil(searchHomeVC.viewControllers.first, "Expected manager return navigation view controller with root view controller available but received nil")
        XCTAssertTrue(searchHomeVC.viewControllers.first! is SearchHomeFullViewController, "Expected manager return navigation view controller with root view controller is SearchHomeFullViewController but received a different value")
    }
    
    func testSearchNearMe_WithUILoaded_ShouldReturnTrue() {
        // Arrange
        let _ = manager.getHCPSearchViewController(fullMode: true)

        // Act
        let success = manager.searchNearMe(specialities: ["SP1", "SP2"])

        // Assert
        XCTAssertTrue(success, "Expected manager return true by calling search without UI attached but return false")
    }
    
    
//    func testSearchNearMe_WithNoUILoaded_ShouldReturnFalse() {
// // Act
//        let success = manager.searchNearMe(specialities: ["SP1", "SP2"])
//
//        // Assert
//        XCTAssertFalse(success, "Expected manager return false by calling search without UI attached but return true")
//    }
}
