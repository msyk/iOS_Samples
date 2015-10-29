//
//  PlaceMapUITests.swift
//  PlaceMapUITests
//
//  Created by Masayuki Nii on 2015/10/29.
//  Copyright © 2015年 Masayuki Nii. All rights reserved.
//

/*

http://presen.msyk.net/hirelink-1510/

*/

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
        
        let app = XCUIApplication()
        XCTAssertEqual(app.tables.count, 1)
        XCTAssertTrue(app.tables.staticTexts["秋田県 [秋田市]"].exists)
        XCTAssertTrue(app.tables.staticTexts["広島県 [広島市]"].exists)
        XCTAssertFalse(app.tables.staticTexts["沖縄県 [首里城]"].exists)
        
        app.tables.staticTexts["秋田県 [秋田市]"].tap()
        XCTAssertEqual(app.maps.count, 1)
        XCTAssertEqual(app.tables.count, 0)

        let map = app.maps.elementBoundByIndex(0)
        let c = map.coordinateWithNormalizedOffset(CGVector(dx: 0.0, dy: 0.0)).screenPoint
        XCTAssertEqual(c, CGPoint(x: 20.0, y: 72.0))
        
        app.navigationBars.buttons.matchingIdentifier("Back").elementBoundByIndex(0).tap();
        XCTAssertEqual(app.tables.count, 1)
        XCTAssertEqual(app.maps.count, 0)

        
//        let app = XCUIApplication()
//        let tablesQuery = app.tables
//        tablesQuery.staticTexts["青森県 [青森市]"].tap()
//        
//        let prefecturalCapitalButton = app.navigationBars.matchingIdentifier("PlaceMap.MapDisplayView").buttons["Prefectural Capital"]
//        prefecturalCapitalButton.tap()
//        tablesQuery.staticTexts["群馬県 [前橋市]"].tap()
//        prefecturalCapitalButton.tap()
        
    }
    
}
