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

// Properties for Core Data objects
@property (nonatomic, strong) NSManagedObjectContext *mainContext;
@property (nonatomic, strong) NSManagedObjectContext *storingContext;
@property (nonatomic, strong) NSManagedObjectContext *fetchingContext;
@property (nonatomic, strong) NSEntityDescription *entityDescPeople;
@property (nonatomic, strong) NSEntityDescription *entityDescCompany;
@property (nonatomic, strong) NSFetchRequest *request;

// for XML parser
@property (nonatomic, strong) NSMutableArray *parsedData;
@property (nonatomic, strong) NSMutableDictionary *currentRecord;
@property (nonatomic, strong) NSMutableString *currentString;
@property (nonatomic, strong) NSDateFormatter *fmt;

@end

@implementation LocalDB

- (instancetype)init
{
#ifdef DEBUG
    NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
    self = [super init];
    self.fmt = [[NSDateFormatter alloc] init];
    [self.fmt setDateFormat: @"yyyy/MM/dd"];
    
    NSError *error = nil;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource: @"Model"
                              withExtension: @"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc]
                                   initWithContentsOfURL: modelURL];
    
    NSPersistentStoreCoordinator
    *pStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                          initWithManagedObjectModel: model];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *storeURL = [fm URLsForDirectory: NSDocumentDirectory
                                 inDomains: NSUserDomainMask][0];
    storeURL = [storeURL URLByAppendingPathComponent: @"localdb.sqlite"];
    NSPersistentStore *pStore
    = [pStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType
                                      configuration: nil
                                                URL: storeURL
                                            options: nil
                                              error: &error];
    if ( pStore == nil )	{
        NSLog( @"Error Description: %@", [error userInfo] );
        return nil;
    }
    
    self.storingContext = [[NSManagedObjectContext alloc]
                           initWithConcurrencyType: NSPrivateQueueConcurrencyType];
    self.storingContext.persistentStoreCoordinator = pStoreCoordinator;
    
    self.mainContext = [[NSManagedObjectContext alloc]
                        initWithConcurrencyType: NSMainQueueConcurrencyType];
    self.mainContext.parentContext = self.storingContext;
    
    self.fetchingContext = [[NSManagedObjectContext alloc]
                            initWithConcurrencyType: NSPrivateQueueConcurrencyType];
    self.fetchingContext.parentContext = self.mainContext;
    
    self.entityDescPeople = [NSEntityDescription entityForName: @"People"
                                        inManagedObjectContext: self.storingContext];
    self.entityDescCompany = [NSEntityDescription entityForName: @"Company"
                                         inManagedObjectContext: self.storingContext];
    
    self.request = [NSFetchRequest fetchRequestWithEntityName: @"People"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"yomi"
                                                                   ascending: YES];
    [self.request setSortDescriptors: @[sortDescriptor]];
    [self.request setFetchBatchSize: 10];
    return self;
}

- (NSFetchedResultsController *)fetchResultController
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    NSFetchedResultsController *fetch
    = [[NSFetchedResultsController alloc]initWithFetchRequest: self.request
                                         managedObjectContext: self.mainContext
                                           sectionNameKeyPath: nil
                                                    cacheName: @"localdb"];
    NSError *error = nil;
    if( ! [fetch performFetch: &error] )    {
        NSLog( @"Error Description: %@", [error userInfo] );
    }
    return fetch;
}

- (void)batchLoad
{
#ifdef DEBUG
    NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
    [self.fetchingContext performBlock: ^(){
#ifdef DEBUG
        NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
        __block NSError *error;
        NSMutableDictionary *resultHash;
        NSURL *resourceURL = [[NSBundle mainBundle] resourceURL];
        
        NSURL *targetFile = [resourceURL URLByAppendingPathComponent: @"company.xml"];
        NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL: targetFile];
        parser.delegate = self;
        self.parsedData = [NSMutableArray array];
        if( ! [parser parse] )  {
            NSLog( @"Error in parsing xml file." );
        } else {
            resultHash = [NSMutableDictionary dictionary];
            [self.parsedData enumerateObjectsUsingBlock:
             ^(NSDictionary *record, NSUInteger idx, BOOL *stop){
                 Company *company = [[Company alloc] initWithEntity: self.entityDescCompany
                                     insertIntoManagedObjectContext: self.fetchingContext];
                 company.company = record[@"company"];
                 company.zip = record[@"zip"];
                 company.section = record[@"section"];
                 company.address = record[@"address"];
                 resultHash[record[@"id"]] = company;
                 if (error) {
                     NSLog( @"Error in Save: %@", error);
                 }
             }];
        }
        [self.fetchingContext save: &error];
       
        targetFile = [resourceURL URLByAppendingPathComponent: @"people.xml"];
        parser = [[NSXMLParser alloc] initWithContentsOfURL: targetFile];
        parser.delegate = self;
        self.parsedData = [NSMutableArray array];
        if( ! [parser parse] )  {
            NSLog( @"Error in parsing xml file." );
        } else {
            [self.parsedData enumerateObjectsUsingBlock:
             ^(NSDictionary *record, NSUInteger idx, BOOL *stop){
                People *person = [[People alloc] initWithEntity: self.entityDescPeople
                                  insertIntoManagedObjectContext: self.fetchingContext];
                 person.name = record[@"name"];
                 person.mail = record[@"mail"];
                 person.phone = record[@"phone"];
                 person.prefecture = record[@"prefecture"];
                 person.yomi = record[@"ruby"];
                 person.birthday = [self.fmt dateFromString: record[@"birthday"]];
                 person.company = resultHash[record[@"company_id"]];
                 [self.fetchingContext save: &error];
                 if (error) {
                     NSLog( @"Error in Save: %@", error);
                 }
             }];
        }
        [self.mainContext performBlock: ^(){
#ifdef DEBUG
            NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
            [self.mainContext save: &error];
            if (error) {
                NSLog( @"Error in Save: %@", error);
            }
            [self.storingContext performBlock: ^(){
#ifdef DEBUG
                NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
                [self.storingContext save: &error];
                if (error) {
                    NSLog( @"Error in Save: %@", error);
                }
            }];
        }];
   }];
}

- (void)batchClear
{
    [self.fetchingContext performBlock: ^(){
        __block NSError *error = nil;
        NSFetchRequest *request;
        NSArray *array;
        
        request = [NSFetchRequest fetchRequestWithEntityName: @"Company"];
        array = [self.fetchingContext executeFetchRequest: request
                                                    error: &error];
        [array enumerateObjectsUsingBlock:
         ^(Company *record, NSUInteger idx, BOOL *stop){
             [self.fetchingContext deleteObject: record];
         }];
        request = [NSFetchRequest fetchRequestWithEntityName: @"People"];
        array = [self.fetchingContext executeFetchRequest: request
                                                    error: &error];
        [array enumerateObjectsUsingBlock:
         ^(People *record, NSUInteger idx, BOOL *stop){
             [self.fetchingContext deleteObject: record];
         }];
        [self.fetchingContext save: &error];
        [self.mainContext performBlock: ^(){
            [self.mainContext save: &error];
            if (error) {
                NSLog( @"Error in Save: %@", error);
            }
            [self.storingContext performBlock: ^(){
                [self.storingContext save: &error];
                if (error) {
                    NSLog( @"Error in Save: %@", error);
                }
            }];
        }];
    }];
}

#pragma - NSXMLParser Delegate Methods

- (void)    parser: (NSXMLParser *)parser
   didStartElement: (NSString *)elementName
      namespaceURI: (NSString *)namespaceURI
     qualifiedName: (NSString *)qualifiedName
        attributes: (NSDictionary *)attributeDict
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    if ( [elementName isEqualToString: @"record"] )    {
        self.currentRecord = [NSMutableDictionary dictionary];
    } else    {
        self.currentString = [NSMutableString string];
    }
}

- (void)    parser: (NSXMLParser *)parser
   foundCharacters: (NSString *)string
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    if ( self.currentString != nil )   {
        [self.currentString appendString: string];
    }
}

- (void)    parser: (NSXMLParser *)parser
     didEndElement: (NSString *)elementName
      namespaceURI: (NSString *)namespaceURI
     qualifiedName: (NSString *)qName
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    if ( [elementName isEqualToString: @"record"] )    {
        [self.parsedData addObject: self.currentRecord];
        self.currentRecord = nil;
    } else    {
        [self.currentRecord setObject: self.currentString
                               forKey: elementName];
        self.currentString = nil;
    }
}

@end
