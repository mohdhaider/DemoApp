//
//  XCTestExtention.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit
import XCTest

extension XCTestCase {
    
    func waitForTimeout(for duration: TimeInterval, callback back:((XCTestExpectation) -> Void)?) {
        let waitExpectation = expectation(description: "Waiting")
        //waitExpectation.isInverted = true
        back?(waitExpectation)
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
    
    func waitForVisible(_ element:XCUIElement, timeout wait:TimeInterval) {
        
        let viewExists = element.waitForExistence(timeout: wait)
        XCTAssertTrue(viewExists)
    }
}
