//
//  ParseData.m
//  1_3_ParseData
//
//  Created by Masayuki Nii on 2013/12/15.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "ParseData.h"
#import "XMLParserType1.h"
#import "XMLParserType2.h"

@implementation ParseData

- (BOOL)parseAsXML1: (NSData *)data
{
    XMLParserType1 *parser = [[XMLParserType1 alloc] initWithData: data];
    if ( [parser parse] == NO ) {
        self.parsedArray = nil;
        NSLog( @"ERROR: NSXMLParser couldn't parse." );
        return NO;
    }
    self.parsedArray = parser.parsingArray;
    return YES;
}

- (BOOL)parseAsXML2: (NSData *)data
{
    XMLParserType2 *parser = [[XMLParserType2 alloc] initWithData: data];
    if ( [parser parse] == NO ) {
        self.parsedArray = nil;
        NSLog( @"ERROR: NSXMLParser couldn't parse." );
        return NO;
    }
    self.parsedArray = parser.parsingArray;
    return YES;
}


- (BOOL)parseAsJSON: (NSData *)data
{
    NSError *error;
    NSJSONSerialization *jsondata
    = [NSJSONSerialization JSONObjectWithData: data
                                      options: 0
                                        error: &error];
    self.parsedArray = (NSArray *)jsondata;
    if ( error != nil ) {
        self.parsedArray = nil;
        NSLog( @"Error on parsing JSON: %@", error );
        return NO;
    }
    return YES;
}

@end
