//
//  LocalDB.h
//  6_CoreDataSample
//
//  Created by Masayuki Nii on 2014/02/02.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class People;

@interface LocalDB : NSObject

@property (nonatomic, strong, readonly)
    NSFetchedResultsController *fetchResultController;

- (BOOL)addPoeople: (NSString *)name;
- (BOOL)deletePeople: (People *)person;

@end
