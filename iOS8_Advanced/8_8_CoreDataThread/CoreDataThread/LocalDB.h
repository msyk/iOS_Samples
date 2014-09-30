//
//  LocalDB.h
//  6_CoreDataSample
//
//  Created by Masayuki Nii on 2014/02/02.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalDB : NSObject <NSXMLParserDelegate>

@property (atomic, strong) NSArray *selectedData;
@property (nonatomic) BOOL isStillInitializing;

-(instancetype) initWithCompletion: (void(^)(void))finishTask;
-(void) selectedPeople: (NSString *)criteria
               orderBy: (NSString *)field
            completion: (void(^)(NSArray *result, NSError *error))finishTask;
-(void) selectedCompany: (NSString *)criteria
                orderBy: (NSString *)field
             completion: (void(^)(NSArray *result, NSError *error))finishTask;

@end
