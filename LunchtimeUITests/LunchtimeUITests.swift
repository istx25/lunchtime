//
//  LunchtimeUITests.swift
//  LunchtimeUITests
//
//  Created by Willow Bumby on 2015-12-21.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

import XCTest

class LunchtimeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testOnboardingFlow() {
        let app = XCUIApplication()
        let element = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        element.tap()
        app.buttons["$30"].tap()
        element.tap()
        
        let shareThisPrivilegeButton = app.buttons["Share this privilege"]
        shareThisPrivilegeButton.tap()

        element.childrenMatchingType(.Other).elementBoundByIndex(1).tap()
        shareThisPrivilegeButton.tap()
        element.tap()
        
        let datePickersQuery = app.datePickers
        datePickersQuery.pickerWheels["06 minutes"].tap()
        
        let element2 = datePickersQuery.otherElements.containingType(.PickerWheel, identifier:"12 o'clock").element
        element2.pressForDuration(0.8);
        element2.tap()
        app.buttons["Done"].tap()
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
