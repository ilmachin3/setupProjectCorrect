//
//  setupUITests.swift
//  setupUITests
//
//  Created by Илья Дышлюк on 21.11.2024.
//

import XCTest

final class ImageFeedUITests: XCTestCase {
    
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testAuth() {
 
        
        app.buttons["Войти"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        sleep(10)
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
        sleep(10)
        loginTextField.tap()
        loginTextField.typeText("")
        webView.swipeUp()
        
        let passwordTexField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTexField.waitForExistence(timeout: 5))
        sleep(4)
        passwordTexField.tap()
        passwordTexField.typeText("")
        webView.swipeUp()
        sleep(10)
        webView.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        print(app.debugDescription)

    }
    
    func testFeed() {
        
        let tablesQuery = app.tables
        
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        sleep(10)
        
        
        sleep(2)
        
        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)
        
        sleep(10)
        cellToLike.buttons["like button"].tap()
        XCTAssertTrue(cellToLike.waitForExistence(timeout: 10))
        sleep(2)

        
        let cellToZoom = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cellToZoom.tap()
        
        let imageView = app.images["zoomable image"]
        XCTAssertTrue(imageView.waitForExistence(timeout: 5), "Failed to find the zoomable image")
        
        // Производим зум
        imageView.pinch(withScale: 2.0, velocity: 1.0) // Например, увеличиваем в 2 раза
        
        sleep(2)
        
        let navBackButtonWhiteButton = app.buttons["nav back button white"]
        navBackButtonWhiteButton.tap()
        sleep(5)
        cell.swipeUp()
    }
    
    func testProfile() {
        sleep(3)
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts["Ilya Dishluk"].exists)
        XCTAssertTrue(app.staticTexts["@ilmachine"].exists)
        
        app.buttons["logoutbutton"].tap()
        app.alerts["Выход"].buttons["Выход"].tap()
    }
}
