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
        continueAfterFailure = false // настройка выполнения тестов, которая прекратит выполнения тестов, если в тесте что-то пошло не так
        
        app.launch() // запускаем приложение перед каждым тестом
    }
    
    func testAuth() throws {
 
        
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
        sleep(10)
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
        sleep(5)
        cell.swipeUp()
        
        sleep(2)
        
        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)
        
        cellToLike.buttons["like button"].tap()
        sleep(2)
        cellToLike.buttons["like button"].tap()
        
        sleep(2)
        
        cellToLike.tap()
        
        sleep(2)
        
        let image = app.scrollViews.images.element(boundBy: 0)
        
        image.pinch(withScale: 3, velocity: 1)
        
        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButtonWhiteButton = app.buttons["nav back button white"]
        navBackButtonWhiteButton.tap()
        
        //        app.buttons["Authenticate"].tap()
        //
        //                let webView = app.webViews["UnsplashWebView"]
        //
        //                let loginTextField = webView.descendants(matching: .textField).element
        //                XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
        //
        //                loginTextField.tap()
        //                loginTextField.typeText("")
        //                webView.swipeUp()
        //
        //                let passwordTexField = webView.descendants(matching: .secureTextField).element
        //                XCTAssertTrue(passwordTexField.waitForExistence(timeout: 5))
        //
        //                passwordTexField.tap()
        //                passwordTexField.typeText("")
        //                webView.swipeUp()
        //
        //                webView.buttons["Login"].tap()
        //
        //                let tablesQuery = app.tables
        //                let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        //
        //                XCTAssertTrue(cell.waitForExistence(timeout: 5))
        //                print(app.debugDescription)
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
