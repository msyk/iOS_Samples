//
//  TestClass.h
//  1_1_OO4ARC
//
//  Created by Masayuki Nii on 2013/12/12.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject
@property(strong, atomic) TestClass *nextObject;
@end
