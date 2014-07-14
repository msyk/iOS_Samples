//
//  LocalDB.m
//  6_CoreDataSample
//
//  Created by Masayuki Nii on 2014/02/02.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "LocalDB.h"
#import "People.h"
#import "Company.h"

@interface LocalDB()

@property (nonatomic, strong) NSFetchRequest *request;
@property (nonatomic, strong) NSEntityDescription *entityDescPeople;
@property (nonatomic, strong) NSManagedObjectContext *moContext;

@end

@implementation LocalDB

- (instancetype)init
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    self = [super init];
    
    NSError *error = nil;
    NSURL *modelURL
    = [[NSBundle mainBundle] URLForResource: @"Model"
                              withExtension: @"momd"];
    NSManagedObjectModel *model
    = [[NSManagedObjectModel alloc] initWithContentsOfURL: modelURL];
    
    NSPersistentStoreCoordinator *pStoreCoordinator
    = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: model];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *storeURL = [fm URLsForDirectory: NSDocumentDirectory
                                 inDomains: NSUserDomainMask][0];
    storeURL = [storeURL URLByAppendingPathComponent: @"localdb.sqlite"];
    
    if ([fm fileExistsAtPath: [storeURL path]]){
        [fm removeItemAtURL: storeURL error: &error];
    }
    
    NSDictionary *dict = @{NSMigratePersistentStoresAutomaticallyOption: @YES,
                          NSInferMappingModelAutomaticallyOption: @YES};
    NSPersistentStore *pStore
    = [pStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType
                                      configuration: nil
                                                URL: storeURL
                                            options: dict
                                              error: &error];
    if ( pStore == nil )	{
        NSLog( @"Error Description: %@", [error userInfo] );
        return self;
    }
    
    self.moContext = [[NSManagedObjectContext alloc] init];
    [self.moContext setPersistentStoreCoordinator: pStoreCoordinator];
    self.entityDescPeople = [NSEntityDescription entityForName: @"People"
                                        inManagedObjectContext: self.moContext];
    self.request = [NSFetchRequest fetchRequestWithEntityName: @"People"];
    
//    NSPredicate *predicate = [NSPredicate predicateWithValue: YES];
//    [self.request setPredicate: predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"name"
                                                                   ascending: NO];
    [self.request setSortDescriptors: @[sortDescriptor]];

    return self;
}

- (NSFetchedResultsController *)fetchResultController
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    NSFetchedResultsController *fetch
    = [[NSFetchedResultsController alloc]initWithFetchRequest: self.request
                                         managedObjectContext: self.moContext
                                           sectionNameKeyPath: nil
                                                    cacheName: @"localdb"];
    NSError *error = nil;
    if( ! [fetch performFetch: &error] )    {
        NSLog( @"Error Description: %@", [error userInfo] );
    }
    return fetch;
}

- (BOOL)addPoeople: (NSString *)name
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    NSError *error;
    People *person = [[People alloc] initWithEntity: self.entityDescPeople
                     insertIntoManagedObjectContext: self.moContext];
    person.name = name;
    person.phonetic = name;
    if( ! [self.moContext save: &error] ) {
        NSLog( @"ERROR: %@", error.description );
    }
    return error == nil ? YES : NO;
}

- (BOOL)deletePeople: (People *)person;
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    NSError *error;
    //People *person = self.selectedData[index];
    [self.moContext deleteObject: person];
    if( ! [self.moContext save: &error] ) {
        NSLog( @"ERROR: %@", error.description );
    }
    return error == nil ? YES : NO;
}

@end
