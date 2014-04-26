//
//  XMLParserType1.m
//  1_3_ParseData
//
//  Created by Masayuki Nii on 2013/12/15.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "XMLParserType1.h"

//#undef DEBUG

@interface XMLParserType1()

@property (nonatomic, strong) NSMutableDictionary *currentRecord;
@property (nonatomic, strong) NSMutableString *currentString;

@end

@implementation XMLParserType1

- (id)init  {
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    self = [super init];
    self.currentString = nil;
    self.currentRecord = nil;
    self.parsingArray = [NSMutableArray array];
    self.delegate = self;
    return self;
}

- (id)initWithData:(NSData *)data
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    self = [super initWithData: data];
    self.currentString = nil;
    self.currentRecord = nil;
    self.parsingArray = [NSMutableArray array];
    self.delegate = self;
    return self;
}

#pragma - NSXMLParser Delegate Methods

- (void)    parser:(NSXMLParser *)parser
   didStartElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qualifiedName
        attributes:(NSDictionary *)attributeDict
{
#ifdef DEBUG
    NSLog( @"%s %@", __FUNCTION__, elementName );
 #endif
    if ( [elementName isEqualToString: @"record"] )    {
        self.currentRecord = [NSMutableDictionary dictionary];
    } else    {
        self.currentString = [NSMutableString string];
    }
}

- (void)    parser:(NSXMLParser *)parser
   foundCharacters:(NSString *)string
{
#ifdef DEBUG
    NSLog( @"%s %@", __FUNCTION__, string );
 #endif
    if ( self.currentString != nil )   {
        [self.currentString appendString: string];
    }
}

- (void)    parser:(NSXMLParser *)parser
     didEndElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName
{
#ifdef DEBUG
    NSLog( @"%s %@", __FUNCTION__, elementName );
#endif
    if ( [elementName isEqualToString: @"record"] )    {
        [self.parsingArray addObject: self.currentRecord];
        self.currentRecord = nil;
    } else    {
        self.currentRecord[elementName] = self.currentString;
        self.currentString = nil;
    }
}


@end
