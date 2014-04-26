//
//  ParseData.h
//  1_3_ParseData
//
//  Created by Masayuki Nii on 2013/12/15.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseData : NSObject

@property(nonatomic, strong) NSArray *parsedArray;

- (BOOL)parseAsXML1: (NSData *)data;
- (BOOL)parseAsXML2: (NSData *)data;
- (BOOL)parseAsJSON: (NSData *)data;

@end
