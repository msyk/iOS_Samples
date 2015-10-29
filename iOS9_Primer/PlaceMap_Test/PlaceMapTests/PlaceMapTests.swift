//
//  PlaceMapTests.swift
//  PlaceMapTests
//
//  Created by Masayuki Nii on 2015/10/29.
//  Copyright © 2015年 Masayuki Nii. All rights reserved.
//

import XCTest
@testable import PlaceMap
class PlaceMapTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let pdb = PlaceDatabase()
        XCTAssertEqual(pdb.places.count, 47)
        XCTAssertEqual(pdb.prefectureOf("沖縄県"), "那覇市")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            let pdb = PlaceDatabase()
            for var i = 0 ; i < 1000 ; i++ {
                pdb.prefectureOf("和歌山県")
            }
        }
    }
    
}
