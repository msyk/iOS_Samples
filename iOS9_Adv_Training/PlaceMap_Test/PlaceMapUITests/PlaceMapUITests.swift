//
//  PlaceMapUITests.swift
//  PlaceMapUITests
//
//  Created by Masayuki Nii on 2015/11/23.
//  Copyright © 2015年 Masayuki Nii. All rights reserved.
//

import XCTest

class PlaceMapUITests: XCTestCase {
        
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
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
//        let app = XCUIApplication()
//        app.tables.staticTexts["\U5bae\U57ce\U770c [\U4ed9\U53f0\U5e02]"].tap()
//        app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.NavigationBar)["PlaceMap.MapDisplayView"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
    }
    
    func testBasicOperation() {
        let app = XCUIApplication()
        XCTAssertEqual(app.tables.count, 1)
        XCTAssertTrue(app.tables.staticTexts["秋田県 [秋田市]"].exists)
        XCTAssertTrue(app.tables.staticTexts["広島県 [広島市]"].exists)
        XCTAssertFalse(app.tables.staticTexts["沖縄県 [首里城]"].exists)
        
        app.tables.staticTexts["秋田県 [秋田市]"].tap()
        XCTAssertTrue(app.staticTexts["秋田県 [秋田市]"].exists)
        XCTAssertEqual(app.maps.count, 1)
        XCTAssertEqual(app.tables.count, 0)
        
        let map = app.maps.elementBoundByIndex(0)
        let c = map.coordinateWithNormalizedOffset(CGVector(dx: 0.0, dy: 0.0)).screenPoint
        XCTAssertEqual(c, CGPoint(x: 16.0, y: 72.0))
        
        app.navigationBars.buttons.matchingIdentifier("Back").elementBoundByIndex(0).tap();
        XCTAssertEqual(app.tables.count, 1)
        XCTAssertEqual(app.maps.count, 0)
    }
}
