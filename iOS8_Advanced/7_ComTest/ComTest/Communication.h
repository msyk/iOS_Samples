//
//  Communication.h
//  ComTest7
//
//  Created by Masayuki Nii on 2013/09/29.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Communication : NSObject
    <NSURLSessionDelegate, NSURLSessionTaskDelegate,
        NSURLSessionDataDelegate, NSURLSessionDownloadDelegate>

@property (strong, nonatomic) NSString *resultString;
@property (strong, nonatomic) NSError *resultError;
@property (        nonatomic) NSInteger responseCode;

- (id)initWithURL: (NSURL *)url;
- (void)delegateToSelf;
- (void)setUserName: (NSString *)username andPasword: (NSString *)password;
- (void)setCompletionBlock: (NSBlockOperation *)bloclOp;
- (void)startCommunication;
- (void)startCommunicationWithURL: (NSURL *)url;

- (void)startDownload;

@end
