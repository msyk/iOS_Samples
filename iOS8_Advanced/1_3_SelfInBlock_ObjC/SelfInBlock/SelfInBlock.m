//
//  SelfInBlock.m
//  1_2_SelfInBlock
//
//  Created by 新居雅行 on 2014/07/11.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "SelfInBlock.h"

@interface SelfInBlock()

@property (strong, nonatomic) void (^block)(void);
@property (strong, nonatomic) NSString *str;

@end

@implementation SelfInBlock

- (void)configureBlock {
    self.block = ^{
        [self doSomething];
    };
}

- (void)configureBlock2 {
    SelfInBlock * __weak weakSelf = self;
    self.block = ^{
        [weakSelf doSomething];
        weakSelf.str = @"Test";
    };
}

- (void)doSomething
{
    NSLog(@"Did something");
}
@end
