//
//  Company.h
//  6_CoreDataSample
//
//  Created by Masayuki Nii on 2014/02/03.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class People;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * section;
@property (nonatomic, retain) NSOrderedSet *people;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)insertObject:(People *)value inPeopleAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPeopleAtIndex:(NSUInteger)idx;
- (void)insertPeople:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePeopleAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPeopleAtIndex:(NSUInteger)idx withObject:(People *)value;
- (void)replacePeopleAtIndexes:(NSIndexSet *)indexes withPeople:(NSArray *)values;
- (void)addPeopleObject:(People *)value;
- (void)removePeopleObject:(People *)value;
- (void)addPeople:(NSOrderedSet *)values;
- (void)removePeople:(NSOrderedSet *)values;
@end
