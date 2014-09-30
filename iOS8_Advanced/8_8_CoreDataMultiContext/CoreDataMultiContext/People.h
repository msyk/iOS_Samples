//
//  People.h
//  6_CoreDataSample
//
//  Created by Masayuki Nii on 2014/02/03.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Company;

@interface People : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * mail;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * prefecture;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * yomi;
@property (nonatomic, retain) Company *company;

@end
