//
//  OO4NoARC.m
//  1_1_OO4ARC
//
//  Created by Masayuki Nii on 2013/12/11.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestClass.h"

@interface OO4NoARC : XCTestCase

@property (strong, nonatomic) NSString *strProp;

@end

@implementation OO4NoARC

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testOwnershipAdding
{
    NSMutableArray *array = [NSMutableArray array];	//要素が0の配列を用意
    NSString *str1 = [[NSString alloc] initWithFormat: @"Number %d", 1];
    NSLog( @"retainCount=%d", [str1 retainCount] );
    [array addObject: str1];
    NSLog( @"retainCount=%d", [str1 retainCount] );
    NSLog( @"%@", array );
    XCTAssertTrue( array.count == 1, @"The array should have just one element.");
}

- (void)testOwnershipAdding2
{
    NSMutableArray *array = [NSMutableArray array];	//要素が0の配列を用意
    NSString *str1 = [[NSString alloc] initWithFormat: @"Number %d", 1];
    NSLog( @"retainCount=%d", [str1 retainCount] );
    [array addObject: str1];
    NSLog( @"retainCount=%d", [str1 retainCount] );
    [array removeObject: str1];
    NSLog( @"retainCount=%d", [str1 retainCount] );
    NSLog( @"%@", array );
    XCTAssertTrue( array.count == 0, @"The array should have no elements.");
}

- (void)testOwnershipAddingTwoObjects
{
    NSMutableArray *array1 = [NSMutableArray array];	//要素が0の配列を用意
    NSMutableArray *array2 = [NSMutableArray array];	//要素が0の配列を用意
    NSString *str1 = [[NSString alloc] initWithFormat: @"Number %d", 1];
    NSLog( @"retainCount=%d", [str1 retainCount] );
    [array1 addObject: str1];
    NSLog( @"retainCount=%d", [str1 retainCount] );
    [array2 addObject: str1];
    NSLog( @"retainCount=%d", [str1 retainCount] );
    XCTAssertTrue( array1.count == 1 && array2.count == 1, @"The array should have just one element.");
}

- (void)testOwnershipAddingProp
{
    NSString *str1 = [[NSString alloc] initWithFormat: @"Number %d", 1];
    NSLog( @"retainCount=%d", [str1 retainCount] );
    self.strProp = str1;
    NSLog( @"retainCount=%d", [str1 retainCount] );
    XCTAssertNotNil( self.strProp, @"The array should NOT nil.");
}

- (void)testOwnershipAddingVar
{
    NSString *str1 = [[NSString alloc] initWithFormat: @"Number %d", 1];
    NSLog( @"retainCount=%d", [str1 retainCount] );
    NSString *str2 = str1;
    NSLog( @"retainCount=%d", [str1 retainCount] );
    NSLog( @"str1=%@, str2=%@", str1, str2 );
    XCTAssertNotNil( str2, @"The array should NOT nil.");
}


- (void)testCyclic
{
    TestClass *obj1 = [[TestClass alloc] init];
    TestClass *obj2 = [[TestClass alloc] init];
    TestClass *obj3 = [[TestClass alloc] init];
    obj1.nextObject = obj2;
    obj2.nextObject = obj3;
    obj3.nextObject = obj1;
    [obj1 release];
    XCTAssertNil( nil, @"The array should be deallocated.");
}


@end
