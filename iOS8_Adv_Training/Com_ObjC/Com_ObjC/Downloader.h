//
//  Downloader.h
//  Com_ObjC
//
//  Created by 新居雅行 on 2015/01/30.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Downloader : NSObject

@property(strong, nonatomic) NSArray *parsedData;

-(id)initWithURL: (NSURL *)url;
-(id)initWithURL: (NSURL *)url
       afterTask: (void(^)(void))doItAfter;

@end
