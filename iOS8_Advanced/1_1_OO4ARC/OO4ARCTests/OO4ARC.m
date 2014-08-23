//
//  OO4ARC.m
//  1_1_OO4ARC
//
//  Created by Masayuki Nii on 2013/12/11.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface OO4ARC : XCTestCase

@property (strong, nonatomic) NSString *strProp;

@end

@implementation OO4ARC
{
    NSString *member1;
}

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
    NSLog( @"retainCount=%ld", CFGetRetainCount((__bridge CFTypeRef)(str1)) );
    [array addObject: str1];
    NSLog( @"retainCount=%ld", CFGetRetainCount((__bridge CFTypeRef)(str1)) );
    NSLog( @"%@", array );
    XCTAssertTrue( array.count == 1, @"The array should have just one element.");
    NSLog( @"size of int = %ld", sizeof(int) );
}

- (void)testOwnershipAddingProp
{
    NSString *str1 = [[NSString alloc] initWithFormat: @"Number %d", 1];
    NSLog( @"retainCount=%ld", CFGetRetainCount((__bridge CFTypeRef)(str1)) );
    self.strProp = str1;
    NSLog( @"retainCount=%ld", CFGetRetainCount((__bridge CFTypeRef)(str1)) );
    XCTAssertNotNil( self.strProp, @"The array should NOT nil.");
}

- (void)testOwnershipAddingVar
{
    NSString *str1 = [[NSString alloc] initWithFormat: @"Number %d", 1];
    NSLog( @"retainCount=%ld", CFGetRetainCount((__bridge CFTypeRef)(str1)) );
    NSString *str2 = str1;
    NSLog( @"retainCount=%ld", CFGetRetainCount((__bridge CFTypeRef)(str1)) );
    NSLog( @"str1=%@, str2=%@", str1, str2 );
    XCTAssertNotNil( str2, @"The array should NOT nil.");
}

- (void)testSynthesizedVariable
{
    NSString *str1 = [[NSString alloc] initWithFormat: @"Number %d", 1];
    NSLog( @"retainCount=%ld", CFGetRetainCount((__bridge CFTypeRef)(str1)) );
    _strProp = str1;
    NSLog( @"retainCount=%ld", CFGetRetainCount((__bridge CFTypeRef)(str1)) );
    member1 = str1;
    NSLog( @"retainCount=%ld", CFGetRetainCount((__bridge CFTypeRef)(str1)) );
    XCTAssertNotNil( str1, @"The array should NOT nil.");
}

@end
