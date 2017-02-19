//
//  Annict_for_iOSUITests.swift
//  Annict-for-iOSUITests
//
//  Created by Yuto Akiba on 2017/02/10.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import XCTest

class Annict_for_iOSUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let application = XCUIApplication()
        application.launchEnvironment = ProcessInfo.processInfo.environment
        setupSnapshot(application)
        application.launch()
        
        snapshot("tab 0")
        let tabbar = application.tabBars.element(boundBy: 0)
        tabbar.buttons.element(boundBy: 1).tap()
        snapshot("tab 1")
        tabbar.buttons.element(boundBy: 2).tap()
        snapshot("tab 2")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
