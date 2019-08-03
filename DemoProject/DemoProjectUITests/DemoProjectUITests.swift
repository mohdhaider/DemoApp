//
//  DemoProjectUITests.swift
//  DemoProjectUITests
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import XCTest

class DemoProjectUITests: XCTestCase {

    var application:XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        XCTContext.runActivity(named: "App Launch") { _ in
            
            continueAfterFailure = false
            
            application = XCUIApplication()
            application.launch()
        }
    }

    override func tearDown() {
        application = nil
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        
        XCTContext.runActivity(named: "Splash Screen") { _ in
            
            func performLogoutFeature() {
                
                XCTContext.runActivity(named: "Details Screen") { _ in
                    
                    let webView = application.otherElements.webViews.firstMatch
                    
                    let viewExists = webView.waitForExistence(timeout: 5)
                    
                    if viewExists {
                        
                        webView.swipeUp()
                        webView.swipeUp()
                        webView.swipeDown()
                        webView.swipeDown()
                        
                        let logoutButton = application.navigationBars.firstMatch.buttons["Logout"]
                        
                        waitForVisible(logoutButton, timeout: 5)
                        logoutButton.tap()
                    } else {
                        XCTFail("Detail Screen UI Elements not found!")
                    }
                }
            }
            
            func performLoginFeature() {
                
                XCTContext.runActivity(named: "Login Screen") { _ in
                    
                    let elementsQuery = application.scrollViews.otherElements
                    
                    let idTextField = elementsQuery.textFields["ID"]
                    idTextField.tap()
                    idTextField.typeText("eve.holt@reqres.in")
                    
                    let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
                    passwordSecureTextField.tap()
                    passwordSecureTextField.typeText("cityslicka")
                    
                    let loginButtonButton = elementsQuery.buttons["Login Button"]
                    loginButtonButton.tap()
                    
                    performLogoutFeature()
                }
            }
            
            let loginScreen = application.otherElements["Login Screen"]
            
            let viewExists = loginScreen.waitForExistence(timeout: 5)
            
            if viewExists {
                performLoginFeature()
            } else {
                performLogoutFeature()
            }
        }
    }
}
