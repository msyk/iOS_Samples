//
//  SampleClassTests.swift
//  SampleClassTests
//
//  Created by 新居雅行 on 2014/09/07.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit
import XCTest

class SampleClassTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let obj = SampleClass()
        
        let str = obj.appendHTMLTaggedString("TEST", withTag:"div")
        XCTAssert(str == "<div>TEST</div>")
        XCTAssert(obj.length() == 0)
        
        //obj.appendString("q")
        //obj.htmlStringCompute = "###"
        
        // Property and Observable
        println(".magicNumber=\(obj.magicNumber)")
        XCTAssert(obj.magicNumber == 4, "Property magicNumber checking")
        obj.tagString = "table"
        XCTAssert(obj.magicNumber == 5, "Property magicNumber checking")

        // Property and lazy initializer
        obj.insideText = "open mind!"
        obj.tagString = "span"
        XCTAssert(obj.htmlStringFix == "<span>open mind!</span>")
        XCTAssert(obj.htmlStringCompute == "<span>open mind!</span>")
        
        obj.insideText = "close the door!"
        obj.tagString = "div"
        XCTAssert(obj.htmlStringFix == "<span>open mind!</span>")
        XCTAssert(obj.htmlStringCompute == "<div>close the door!</div>")

        // Setter / Getter
        let element1 = KeyValue(key: "myKey", value: "myValue");
        obj.attribute = element1
        let element2 = KeyValue(key: "yourKey", value: "yourValue");
        obj.attribute = element2
        
        println(obj.attributeValueFromKey("myKey"))
        XCTAssert(obj.attributeValueFromKey("myKey") == "myValue")
        XCTAssert(obj.attributeValueFromKey("yourKey") == "yourValue")
  
        // Subscript
        XCTAssert(obj[0] == "#HTML")
        XCTAssert(obj[1] == "#close the door!")
        XCTAssert(obj[500] == "#no way")
        XCTAssert(obj["class"] == "Sample Class")
        XCTAssert(obj["auther"] == "It's me")
        XCTAssert(obj["oops"] == "info")
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
