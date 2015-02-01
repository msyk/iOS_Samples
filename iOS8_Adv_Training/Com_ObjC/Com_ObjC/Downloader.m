//
//  Downloader.m
//  Com_ObjC
//
//  Created by 新居雅行 on 2015/01/30.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

#import "Downloader.h"

@implementation Downloader

-(id)initWithURL: (NSURL *)url afterTask: (void(^)(void))doItAfter
{
    if ((self = [super init]))  {
        NSURLSessionConfiguration *config
        = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session
        = [NSURLSession sessionWithConfiguration: config];
        NSURLSessionDataTask *task
        = [session dataTaskWithURL: url
         completionHandler: ^(NSData *data,
                              NSURLResponse *response,
                              NSError *error){
             NSError *jsonError;
             self.parsedData
             = [NSJSONSerialization JSONObjectWithData: data
                                               options: NSJSONReadingAllowFragments
                                                 error: &jsonError];
             NSLog( @"receivedData = %@", self.parsedData);
             [[NSOperationQueue mainQueue] addOperationWithBlock: doItAfter];
             [session finishTasksAndInvalidate];
         }];
        [task resume];
    }
    return self;
}

-(id)initWithURL: (NSURL *)url
{
    if ((self = [super init]))  {
        NSURLSessionConfiguration *config
        = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session
        = [NSURLSession sessionWithConfiguration: config
                                        delegate: nil
                                   delegateQueue: nil];
        NSURLSessionDataTask *task
        = [session dataTaskWithURL: url
                 completionHandler: ^(NSData *data,
                                      NSURLResponse *response,
                                      NSError *error){
                     NSLog( @"receivedData = %@",
                           [[NSString alloc] initWithData: data
                                                 encoding: NSUTF8StringEncoding]);
                     [session finishTasksAndInvalidate];
                 }];
        [task resume];
    }
    return self;
}
@end
