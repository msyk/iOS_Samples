//
//  __2_BlocksTests.m
//  1_2_BlocksTests
//
//  Created by Masayuki Nii on 2013/12/15.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BlocksTests : XCTestCase

@end

@implementation BlocksTests

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

- (void)testExample
{
    // ================================= Trial 1
    void (^proc1)(void) = ^(void){
        NSLog( @"==proc1==" );
    };
//    proc1;
    proc1();
    XCTAssertTrue(true, @"Test is over.");

    // ================================= Trial 2
    int (^proc2)(id, int) = ^(id str, int c){
        for(int i=0; i < c; i++) {
            NSLog( @"%@", str );
        }
        return 99;
    };
    int x = proc2( @"Song", 3 ); // 「Song」が3行渡って出力される
    NSLog( @"x = %d", x); // xの値は99
    XCTAssert(x == 99, @"The variable x has the value 99.");
    
    // ================================= Trial 3
    __block int b = 100;
    int c = 200;
    void (^proc3)(void) = ^(void){ b = b + c; };
    proc3();
    NSLog( @"b=%d", b ); // bの値は300
    XCTAssert(b == 300, @"The variable b has the value 300.");
    proc3();
    NSLog( @"b=%d", b ); // bの値は500
    XCTAssert(b == 500, @"The variable b has the value 500.");

    // ================================= Trial 4
    function1( 3, ^(id x,int y) { NSLog(@"%@,%d",x,y); });	//コンソールには「pack,3」と表示される

    void(^f1)(id,int) = ^(id x, int y){ NSLog(@"%@,%d",x,y); };
    function1( 3, f1 );	//コンソールには「pack,3」と表示される
    
    // ================================= Trial 5
    int r = function2( 3, ^(id x,int y) { return 4; } );
    NSLog( @"r = %d", r); // rの値は4
    XCTAssert(r == 4, @"The variable r has the value 4.");

    // ================================= Trial 6
    
    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock: ^(void) {
        NSLog( @"Inside of the block, Now!" );
    }];
	
    [bo start];

    // ===========================================
    
    sleep(1);
    
}

void function1( int a, void (^b)(id,int)) {
	b( @"pack", a);
}

int function2( int a, int (^b)(id,int))	{
	int i=b(@"pack", a);
	return i;
}

@end
