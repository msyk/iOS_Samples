//
//  TestClass.h
//  SwiftAndObjC
//
//  Created by 新居雅行 on 2014/09/24.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject

@property (nonatomic, strong) NSString *name;
- (NSString *)deluxName: (NSString *)prefix;

@end
