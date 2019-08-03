//
//  DemoProjectTests.swift
//  DemoProjectTests
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import XCTest
@testable import DemoProject

class DemoProjectTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() {
        // This is an example of a functional test case.
        
        var expectation: XCTestExpectation?
        
        let viewModel = LoginViewModel()
        
        viewModel.isAccessTokenGeneretd.bind { (isGenerated) in
            if isGenerated {
                expectation?.fulfill()
            } else {
                XCTFail("Unable to save access token")
            }
        }
        
        viewModel.errorInfo.bind { (error) in
            if !error.isEmpty {
                XCTFail("Unable to save access token")
            }
        }
        
        XCTContext.runActivity(named: "Login Api Check") { _ in
            
            waitForTimeout(for: 10,
                           callback: { (exp) in
                            expectation = exp
                            do {
                              try viewModel.performLoginApi(forUsername: "eve.holt@reqres.in", forPassword: "cityslicka")
                            } catch {
                                XCTFail(error.localizedDescription)
                            }
            })
        }
    }
}
