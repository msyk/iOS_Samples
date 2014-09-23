//
//  PersonData.m
//  3_TableExample
//
//  Created by Masayuki Nii on 2014/01/06.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "PersonData.h"

@interface PersonData()
@property (nonatomic, strong) NSMutableArray *context;
@property (nonatomic, strong) NSURL *plistFile;
@end

@implementation PersonData

- (id)init
{
#ifdef DEBUG
    NSLog( @"%s STORE_DOCUMENTS is defined.", __FUNCTION__);
#endif
    self = [super init];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *docDirs = [fm URLsForDirectory: NSDocumentDirectory
                                  inDomains: NSUserDomainMask];
    self.plistFile = [docDirs[0] URLByAppendingPathComponent: @"data.plist"];
    NSError *error;
    if (![self.plistFile checkResourceIsReachableAndReturnError: &error])   {
        NSURL *plistFile = [[NSBundle mainBundle] URLForResource: @"person"
                                                   withExtension: @"plist"];
        if(![fm copyItemAtURL: plistFile toURL: self.plistFile error: &error])  {
            NSLog(@"Copy Error");
        }
    }
    NSArray *fileContent = [[NSArray alloc] initWithContentsOfURL: self.plistFile];
    self.context = [[NSMutableArray alloc] initWithArray: fileContent];
    
    return self;
    
}

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
    return [self.context writeToURL: self.plistFile atomically: YES];
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
