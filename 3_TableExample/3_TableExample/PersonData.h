//
//  PersonData.h
//  3_TableExample
//
//  Created by Masayuki Nii on 2014/01/06.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonData : NSObject

@property (nonatomic, strong, readonly) NSArray *people;
@property (nonatomic, strong, readonly) NSArray *fieldNames;

- (BOOL)save;
- (void)insert;
- (void)setRecord: (NSDictionary *)record atIndex: (NSInteger)index;
- (void)delete: (NSInteger)index;
- (void)moveTo: (NSInteger)index from: (NSInteger)index;

@end
