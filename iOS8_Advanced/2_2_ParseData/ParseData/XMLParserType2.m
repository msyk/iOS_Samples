//
//  XMLParserType2.m
//  1_3_ParseData
//
//  Created by Masayuki Nii on 2013/12/15.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "XMLParserType2.h"

//#undef DEBUG

@interface XMLParserType2()

@property (nonatomic, strong) NSMutableDictionary *currentRecord;
@property (nonatomic, strong) NSMutableString *currentKey;
@property (nonatomic, strong) NSMutableString *currentValue;

@end

@implementation XMLParserType2

- (id)init  {
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    self = [super init];
    self.currentKey = nil;
    self.currentValue = nil;
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
    self.currentKey = nil;
    self.currentValue = nil;
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
    } else  if ( [elementName isEqualToString: @"key"] )    {
        self.currentKey = [NSMutableString string];
    } else  if ( [elementName isEqualToString: @"value"] )    {
        self.currentValue = [NSMutableString string];
    } else  {
        // nothing to do so far
    }
}

- (void)    parser:(NSXMLParser *)parser
   foundCharacters:(NSString *)string
{
#ifdef DEBUG
    NSLog( @"%s %@", __FUNCTION__, string );
#endif
    
    if ( self.currentValue != nil )   {
        [self.currentValue appendString: string];
    } else if ( self.currentKey != nil )   {
        [self.currentKey appendString: string];
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
    } else  if ( [elementName isEqualToString: @"key"] )    {
        // nothing to do so far
    } else  if ( [elementName isEqualToString: @"value"] )    {
        self.currentRecord[self.currentKey] = self.currentValue;
        self.currentKey = nil;
        self.currentValue = nil;
    } else    {
        // nothing to do so far
    }
}

@end
