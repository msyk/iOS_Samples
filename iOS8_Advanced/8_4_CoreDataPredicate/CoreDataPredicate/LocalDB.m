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

@property (nonatomic, strong) NSEntityDescription *entityDescPeople;
@property (nonatomic, strong) NSEntityDescription *entityDescCompany;
@property (nonatomic, strong) NSManagedObjectContext *moContext;
@property (nonatomic, strong) NSManagedObjectModel *model;

@property (nonatomic, strong) NSMutableArray *parsedData;
@property (nonatomic, strong) NSMutableDictionary *currentRecord;
@property (nonatomic, strong) NSMutableString *currentString;

-(void)readFromXMLFiles;
- (void)predicateChecking;

@end

@implementation LocalDB

-(instancetype) init
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    self = [super init];
    
    NSError *error = nil;
    NSURL *modelURL
    = [[NSBundle mainBundle] URLForResource: @"Model"
                              withExtension: @"momd"];
    self.model
    = [[NSManagedObjectModel alloc] initWithContentsOfURL: modelURL];
    
    NSPersistentStoreCoordinator *pStoreCoordinator
    = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: self.model];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *storeURL = [fm URLsForDirectory: NSDocumentDirectory
                                 inDomains: NSUserDomainMask][0];
    storeURL = [storeURL URLByAppendingPathComponent: @"localdb.sqlite"];
    
    
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
    self.entityDescCompany = [NSEntityDescription entityForName: @"Company"
                                         inManagedObjectContext: self.moContext];
    
//    [self clearAllRecords];
    
    NSArray *peopleInDB = [self selectedPeople: nil orderBy: nil];
    if ( peopleInDB.count < 1 ) {
        [self readFromXMLFiles];
    }
    
    [self predicateChecking];

    return self;
}

- (void)predicateChecking
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"People"];
    
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat: @"serial > %@", @30];
    
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"yyyy/MM/DD"];
        NSDate *aDate = [df dateFromString: @"1980/01/01"];
       predicate = [NSPredicate predicateWithFormat: @"birthday > %@", aDate];
    
      predicate = [NSPredicate predicateWithFormat: @"name BEGINSWITH %@", @"大"];
     predicate = [NSPredicate predicateWithFormat: @"name CONTAINS %@", @"大"];
      predicate = [NSPredicate predicateWithFormat: @"name ENDSWITH %@", @"子"];
    predicate = [NSPredicate predicateWithFormat: @"name LIKE %@", @"*大*"];
        predicate = [NSPredicate predicateWithFormat: @"serial BETWEEN {%@, %@}", @20, @23];
    //predicate = [NSPredicate predicateWithFormat: @"%@ STARTWITH %@", @"name", @"大"];
    predicate = [NSPredicate predicateWithFormat: @"%K like %@", @"name", @"*大*"];
    predicate = [NSPredicate predicateWithFormat: @"%K BEGINSWITH %@", @"name", @"大"];
    predicate = [NSPredicate predicateWithFormat: @"phonetic > %@", @"ま"];
    predicate = [NSPredicate predicateWithFormat: @"name MATCHES %@", @"松.+子"];
    predicate = [NSPredicate predicateWithFormat: @"age > %@", @30];
    
    predicate =  [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        People *person = evaluatedObject;
        return ([person.age integerValue] > 30);
        
    }]; // SQL not support block
    [request setPredicate: predicate];
   

    
        request = [self.model fetchRequestTemplateForName: @"nameRange1"];
    request = [self.model fetchRequestFromTemplateWithName: @"serialRange"
                                     substitutionVariables: @{@"start": @"12", @"end":@"13"}];
    request = [self.model fetchRequestFromTemplateWithName: @"nameRange"
                                     substitutionVariables: @{@"start": @"あ", @"end":@"か"}];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"phonetic"
                                                                   ascending: NO];
    [request setSortDescriptors: @[sortDescriptor]];
   
    
    
    NSError *error = nil;
    NSArray *array = [self.moContext executeFetchRequest: request
                                                   error: &error];
    NSLog( @"predicateChecking: ERROR=%@\nPredicate = %@", error.description, request );
    [array enumerateObjectsUsingBlock: ^(People *people, NSUInteger idx, BOOL *stop){
        NSLog( @"[%@][%@][%@]", people.serial, people.name, people.birthday );
    }];
}

-(void) clearAllRecords
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    NSArray *array = [self selectedPeople: nil orderBy: nil];
    for ( People *person in array )	{
        [self.moContext deleteObject: person];
    }
    array = [self selectedCompany: nil orderBy: nil];
    for ( Company *company in array )	{
        [self.moContext deleteObject: company];
    }
    NSError *error = nil;
    [self.moContext save: &error];
    if ( error != nil )	{
        NSLog( @"ERROR: %@", [error	description] );
    }
}

-(NSArray *) selectedPeople: (NSString *)criteria orderBy: (NSString *)field
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"People"];
    
    NSPredicate *predicate;
    if ( criteria == nil )  {
        predicate = [NSPredicate predicateWithValue: YES];
    } else {
        predicate = [NSPredicate predicateWithFormat: @"group BEGINSWITH %@", criteria];
    }
    [request setPredicate: predicate];
    
    if ( field != nil)  {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: field
                                                                       ascending: NO];
        [request setSortDescriptors: @[sortDescriptor]];
    }
    NSError *error = nil;
    NSArray *array = [self.moContext executeFetchRequest: request
                                                   error: &error];
    NSLog( @"fetched: %d", array.count );
    if (array == nil)    {
        NSLog( @"ERROR: %@", error.description );
    }
    return array;
}

-(NSArray *) selectedPeopleFrom: (NSString *)criteria1
                             to: (NSString *)criteria2
                        orderBy: (NSString *)field
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"People"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"phonetic > %@ AND phonetic < %@", criteria1, criteria2];
    [request setPredicate: predicate];
    
    if ( field != nil)  {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: field
                                                                       ascending: YES];
        [request setSortDescriptors: @[sortDescriptor]];
    }
    NSError *error = nil;
    NSArray *array = [self.moContext executeFetchRequest: request
                                                   error: &error];
    NSLog( @"fetched: %d", array.count );
    if (array == nil)    {
        NSLog( @"ERROR: %@", error.description );
    }
    return array;
}

-(NSArray *) selectedCompany: (NSString *)criteria orderBy: (NSString *)field
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Company"];

    [request setEntity: self.entityDescCompany];
    NSPredicate *predicate;
    if ( criteria == nil )  {
        predicate = [NSPredicate predicateWithValue: YES];
    } else {
        predicate = [NSPredicate predicateWithFormat: @"company BEGINSWITH %d", criteria];
    }
    [request setPredicate: predicate];
    
    if ( field != nil)  {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: field
                                                                   ascending: NO];
    [request setSortDescriptors: [NSArray arrayWithObject: sortDescriptor]];
    }
    NSError *error = nil;
    NSArray *array = [self.moContext executeFetchRequest: request error:&error];
    if (array == nil)    {
        NSLog( @"ERROR: %@", error.description );
    }
    return array;
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
    
    __block int serial = 0;
    [self.parsedData enumerateObjectsUsingBlock:
     ^(NSDictionary *record, NSUInteger idx, BOOL *stop){
         People *person = [[People alloc] initWithEntity: self.entityDescPeople
                          insertIntoManagedObjectContext: self.moContext];
         person.name = record[@"name"];
         person.name = record[@"name"];
         person.mail = record[@"mail"];
         person.phone = record[@"phone"];
         person.prefecture = record[@"prefecture"];
         person.birthday = [fmt dateFromString: record[@"birthday"]];
         person.phonetic = record[@"ruby"];
         person.company = resultHash[record[@"company_id"]];
         person.serial = [NSNumber numberWithInt: serial++];
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
