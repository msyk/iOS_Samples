//
//  PersonData.m
//  3_TableExample
//
//  Created by Masayuki Nii on 2014/01/06.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

//#define STORE_DOCUMENTS

#import "PersonData.h"

@interface PersonData()
@property (nonatomic, strong) NSMutableArray *context;
@property (nonatomic, strong) NSString *plistFile;
@end

@implementation PersonData

#ifndef STORE_DOCUMENTS
- (id)init
{
#ifdef DEBUG
    NSLog( @"%s STORE_DOCUMENTS isn't defined.", __FUNCTION__);
#endif
    self = [super init];
    
    self.plistFile = [[NSBundle mainBundle] pathForResource: @"person"
                                                     ofType: @"plist"];
    NSArray *fileContent = [[NSArray alloc] initWithContentsOfFile: self.plistFile];
    self.context = [[NSMutableArray alloc] initWithArray: fileContent];
    
    return self;
}

#else

#define DATA_FILE @"persondata.plist"

- (id)init
{
#ifdef DEBUG
    NSLog( @"%s STORE_DOCUMENTS is defined.", __FUNCTION__);
#endif
    self = [super init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentsDir = paths[0];
    NSString *dataFile = [documentsDir stringByAppendingPathComponent: DATA_FILE];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileContent;
    if ( [fm fileExistsAtPath: dataFile])   {
        fileContent = [[NSArray alloc] initWithContentsOfFile: dataFile];
    } else {
        NSString *rsrcPlistFile = [[NSBundle mainBundle] pathForResource: @"person"
                                                                  ofType: @"plist"];
        fileContent = [[NSArray alloc] initWithContentsOfFile: rsrcPlistFile];
    }
    self.context = [[NSMutableArray alloc] initWithArray: fileContent];
    self.plistFile = dataFile;
    
    return self;
    
}

#endif

- (NSArray *)fieldNames //**Getter**
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    return @[@"name", @"keitai", @"birthday", @"age"];
}

- (BOOL)save
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    return [self.context writeToFile: self.plistFile atomically: YES];
}

- (NSArray *)people
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    return self.context;
}

- (void)setRecord: (NSDictionary *)record atIndex: (NSInteger)index
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    self.context[index] = record;
}

- (void)insert
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [self.context insertObject: @{@"name": @"",
                                  @"keitai": @"",
                                  @"birthday": @"",
                                  @"age": @0}
                       atIndex: 0];
    if ( ! [self save] )    {
        NSLog( @"Error" );
    }
}

- (void)delete: (NSInteger)index
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [self.context removeObjectAtIndex: index];
}

- (void)moveTo: (NSInteger)to from: (NSInteger)from;
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    id fromObject = [self.context objectAtIndex: from];
    [self.context removeObjectAtIndex: from];
    [self.context insertObject: fromObject atIndex: to];
}

@end
