//
//  XMLParserType2.h
//  1_3_ParseData
//
//  Created by Masayuki Nii on 2013/12/15.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParserType2 : NSXMLParser <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *parsingArray;

@end
