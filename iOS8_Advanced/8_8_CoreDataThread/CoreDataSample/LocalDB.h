//
//  LocalDB.h
//  6_CoreDataSample
//
//  Created by Masayuki Nii on 2014/02/02.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalDB : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSArray *selectedData;

-(void) clearAllRecords;
-(NSArray *) selectedPeople: (NSString *)criteria orderBy: (NSString *)field;
-(NSArray *) selectedCompany: (NSString *)criteria orderBy: (NSString *)field;

@end
