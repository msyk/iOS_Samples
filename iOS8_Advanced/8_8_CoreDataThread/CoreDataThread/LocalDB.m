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
@property (nonatomic, strong) NSManagedObjectContext *moContext;
@property (nonatomic, strong) NSEntityDescription *entityDescPeople;
@property (nonatomic, strong) NSEntityDescription *entityDescCompany;
// Fetched Array for the Table View
@property (atomic, strong) NSArray *selectedArray;
// for XML parser
@property (nonatomic, strong) NSMutableArray *parsedData;
@property (nonatomic, strong) NSMutableDictionary *currentRecord;
@property (nonatomic, strong) NSMutableString *currentString;

// Do it another thread
@property (nonatomic, strong) NSOperationQueue *queue;

- (void)readFromXMLFiles;

@end

@implementation LocalDB

-(instancetype) initWithCompletion: (void(^)(void))finishTask
{
#ifdef DEBUG
    NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
    self = [super init];
    self.isStillInitializing = YES;
    self.selectedArray = nil;
    
    self.queue = [[NSOperationQueue alloc] init];
    self.queue.maxConcurrentOperationCount = 1;
    
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
    
    [self.queue addOperationWithBlock: ^(void){
        self.moContext = [[NSManagedObjectContext alloc] init];
        self.moContext.persistentStoreCoordinator = pStoreCoordinator;
        self.entityDescPeople = [NSEntityDescription entityForName: @"People"
                                            inManagedObjectContext: self.moContext];
        self.entityDescCompany = [NSEntityDescription entityForName: @"Company"
                                             inManagedObjectContext: self.moContext];
        
        [self selectedPeople: nil
                     orderBy: nil
                  completion: ^(NSArray *result, NSError *error){
                      if ( error == nil && result.count < 1 ) {
                          [self readFromXMLFiles];
                      }
                      self.isStillInitializing = NO;
                      finishTask();
                  }];
    }];
    return self;
}

-(void) selectedPeople: (NSString *)criteria
               orderBy: (NSString *)field
            completion: (void(^)(NSArray *result, NSError *error))finishTask
{
#ifdef DEBUG
    NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"People"];
    
    if ( criteria != nil )  {
        NSPredicate *predicate;
        predicate = [NSPredicate predicateWithFormat: @"name BEGINSWITH %@", criteria];
        [request setPredicate: predicate];
    }
    
    if ( field != nil)  {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: field
                                                                       ascending: NO];
        [request setSortDescriptors: @[sortDescriptor]];
    }
    [self.queue addOperationWithBlock: ^(void){
        NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
        
        NSError *error = nil;
        NSArray *array = [self.moContext executeFetchRequest: request
                                                       error: &error];
        finishTask(array, error);
    }];
}

-(void) selectedCompany: (NSString *)criteria
                orderBy: (NSString *)field
             completion: (void(^)(NSArray *result, NSError *error))finishTask
{
#ifdef DEBUG
    NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Company"];
    
    if ( criteria != nil )  {
        NSPredicate *predicate;
        predicate = [NSPredicate predicateWithFormat: @"company BEGINSWITH %d", criteria];
        [request setPredicate: predicate];
    }
    
    if ( field != nil)  {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: field
                                                                       ascending: NO];
        [request setSortDescriptors: [NSArray arrayWithObject: sortDescriptor]];
    }
    [self.queue addOperationWithBlock: ^(void){
        NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
        
        NSError *error = nil;
        NSArray *array = [self.moContext executeFetchRequest: request
                                                       error: &error];
        finishTask(array, error);
    }];
}

- (void)setSelectedData:(NSArray *)selectedData
{
#ifdef DEBUG
    NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
    self.selectedArray = selectedData;
}

- (NSInteger)countSelectedData
{
    return self.selectedArray.count;
}

- (NSDictionary *)selectedDataOfIndex: (NSInteger)index
{
#ifdef DEBUG
    NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
#endif
    __block NSDictionary *aRecord;
    [self.queue addOperationWithBlock: ^(void){
        NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);
        
        People *person = self.selectedArray[index];
        aRecord = @{@"name": person.name,
                    @"mail": person.mail,
                    @"phone": person.phone,
                    @"prefecture": person.prefecture,
                    @"birthday": person.birthday,
                    @"company": @{@"company": person.company.company,
                                  @"zip": person.company.zip,
                                  @"address": person.company.address,
                                  @"section": person.company.section}};
    }];
    [self.queue waitUntilAllOperationsAreFinished];
    return aRecord;
}

-(void)readFromXMLFiles
{
    NSURL *resourceURL = [[NSBundle mainBundle] resourceURL];
    
    NSURL *targetFile = [resourceURL URLByAppendingPathComponent: @"company.xml"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL: targetFile];
    parser.delegate = self;
    self.parsedData = [NSMutableArray array];
    if( ! [parser parse] )  {
        NSLog( @"Error in parsing xml file." );
        return;
    }
    
    NSError *error;
    NSMutableDictionary *resultHash = [NSMutableDictionary dictionary];
    [self.parsedData enumerateObjectsUsingBlock:
     ^(NSDictionary *record, NSUInteger idx, BOOL *stop){
         Company *company = [[Company alloc] initWithEntity: self.entityDescCompany
                             insertIntoManagedObjectContext: self.moContext];
         company.company = record[@"company"];
         company.zip = record[@"zip"];
         company.section = record[@"section"];
         company.address = record[@"address"];
         resultHash[record[@"id"]] = company;
     }];
    
    targetFile = [resourceURL URLByAppendingPathComponent: @"people.xml"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL: targetFile];
    parser.delegate = self;
    self.parsedData = [NSMutableArray array];
    if( ! [parser parse] )  {
        NSLog( @"Error in parsing xml file." );
        return;
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat: @"yyyy/MM/dd"];
    
    [self.parsedData enumerateObjectsUsingBlock:
     ^(NSDictionary *record, NSUInteger idx, BOOL *stop){
         People *person = [[People alloc] initWithEntity: self.entityDescPeople
                          insertIntoManagedObjectContext: self.moContext];
         person.name = record[@"name"];
         person.mail = record[@"mail"];
         person.phone = record[@"phone"];
         person.prefecture = record[@"prefecture"];
         person.birthday = [fmt dateFromString: record[@"birthday"]];
         person.company = resultHash[record[@"company_id"]];
     }];
    [self.moContext save: &error];
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
