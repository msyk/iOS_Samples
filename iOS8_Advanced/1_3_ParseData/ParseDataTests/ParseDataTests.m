//
//  __3_ParseDataTests.m
//  1_3_ParseDataTests
//
//  Created by Masayuki Nii on 2013/12/15.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ParseData.h"
#import "GDataXMLNode.h"
//#import "ParseData-Swift.h"

@interface ParseDataTests : XCTestCase

@end

@implementation ParseDataTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJSONParsing
{
    NSString *jsonFile = [[NSBundle mainBundle] pathForResource: @"TestData" ofType: @"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile: jsonFile];
    XCTAssertNotNil(jsonData, @"TestData.json should have anything.");
    
    ParseData *parser = [[ParseData alloc] init];
    XCTAssertNotNil(parser, @"ParserData class should be instanciate.");
    BOOL parseResult = [parser parseAsJSON: jsonData];
    XCTAssertTrue(parseResult, @"Parsing should be scucess.");
    XCTAssertTrue(parser.parsedArray.count > 0, @"Should be retrieve any data");
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    [parser.parsedArray writeToFile: [rootPath stringByAppendingPathComponent: @"person.plist"] atomically: YES];
    
    NSDictionary *firstRecord = parser.parsedArray[0];
    XCTAssertTrue(firstRecord.count > 0, @"Should have any fields");
    XCTAssertTrue([firstRecord[@"name"] isEqualToString: @"阿久津根 窈"], @"The name field of first record checked.");
    //    NSLog( @"%@", parser.parsedArray);
}

- (void)testXML1Parsing
{
    NSString *jsonFile = [[NSBundle mainBundle] pathForResource: @"TestData1" ofType: @"xml"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile: jsonFile];
    XCTAssertNotNil(jsonData, @"TestData1.xml should have anything.");
    
    ParseData *parser = [[ParseData alloc] init];
    XCTAssertNotNil(parser, @"ParserData class should be instanciate.");
    BOOL parseResult = [parser parseAsXML1: jsonData];
    XCTAssertTrue(parseResult, @"Parsing should be scucess.");
    XCTAssertTrue(parser.parsedArray.count > 0, @"Should be retrieve any data");
    
    NSDictionary *firstRecord = parser.parsedArray[0];
    XCTAssertTrue(firstRecord.count > 0, @"Should have any fields");
    XCTAssertTrue([firstRecord[@"name"] isEqualToString: @"阿久津根 窈"], @"The name field of first record checked.");
    //    NSLog( @"%@", parser.parsedArray);
}

- (void)testXML2Parsing
{
    NSString *jsonFile = [[NSBundle mainBundle] pathForResource: @"TestData2" ofType: @"xml"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile: jsonFile];
    XCTAssertNotNil(jsonData, @"TestData1.xml should have anything.");
    
    ParseData *parser = [[ParseData alloc] init];
    XCTAssertNotNil(parser, @"ParserData class should be instanciate.");
    BOOL parseResult = [parser parseAsXML2: jsonData];
    XCTAssertTrue(parseResult, @"Parsing should be scucess.");
    XCTAssertTrue(parser.parsedArray.count > 0, @"Should be retrieve any data");
    
    NSDictionary *firstRecord = parser.parsedArray[0];
    XCTAssertTrue(firstRecord.count > 0, @"Should have any fields");
    XCTAssertTrue([firstRecord[@"name"] isEqualToString: @"阿久津根 窈"], @"The name field of first record checked.");
    NSLog( @"%@", parser.parsedArray);
}

- (void)testGenerateXML
{
    GDataXMLElement *bodyElement = [GDataXMLElement elementWithName: @"records"];
    GDataXMLElement *element, *parent;
    parent = [GDataXMLElement elementWithName: @"record"];
    element = [GDataXMLElement elementWithName: @"name"
                                   stringValue: @"My Name"];
    [parent addChild: element];
    
    NSArray *x = [parent elementsForName: @"name"];
    NSLog(@"%@", x);
    
    element = [GDataXMLElement elementWithName: @"ruby"
                                   stringValue: @"My Name"];
    [parent addChild: element];
    [bodyElement addChild: parent];
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithRootElement: bodyElement];
    [xmlDoc setCharacterEncoding: @"utf-8"];

    NSLog(@"%@", [[NSString alloc] initWithData: [xmlDoc XMLData] encoding: NSUTF8StringEncoding]);
    NSLog(@"%@", [bodyElement XMLString]);
}

- (void)testGenerateXMLSwift
{
    GenerateXML *xmlGenerator = [[GenerateXML alloc] init];
    [xmlGenerator testGenerateXML];
}

@end
