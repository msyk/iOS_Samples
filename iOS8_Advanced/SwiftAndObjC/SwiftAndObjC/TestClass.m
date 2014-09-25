//
//  TestClass.m
//  SwiftAndObjC
//
//  Created by 新居雅行 on 2014/09/24.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

- (NSString *)deluxName: (NSString *)prefix
{
    return [NSString stringWithFormat:@"%@ %@", prefix, self.name];
}
@end
