//
//  Communication.m
//  ComTest7
//
//  Created by Masayuki Nii on 2013/09/29.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "Communication.h"
#import "AppDelegate.h"

@interface Communication()

@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURL *currentURL;
@property (        nonatomic) BOOL isDelegateSelf;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) NSBlockOperation *doOnComplete;
@property (        nonatomic) NSInteger countError;
@property (        nonatomic) BOOL isDownload;

@property (        nonatomic) UIBackgroundTaskIdentifier backId;

@end

@implementation Communication

- (id)initWithURL: (NSURL *)url
{
    self = [super init];
    if (self)   {
        self.currentURL = url;
        self.isDelegateSelf = NO;
        self.isDownload = NO;
    }
    return self;
}

- (void)startCommunicationWithURL: (NSURL *)url
{
    self.currentURL = url;
    [self startCommunication];
}

- (void)delegateToSelf
{
    self.isDelegateSelf = YES;
}

- (void)setUserName: (NSString *)username andPasword: (NSString *)password
{
    self.username = username;
    self.password = password;
}

- (void)setCompletionBlock: (NSBlockOperation *)bloclOp
{
    self.doOnComplete = bloclOp;
}

- (void)startCommunication
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
    NSLog( @"Is main thread ? %@", [NSThread isMainThread] ? @"YES" : @"NO");
#endif
    
    self.resultString = nil;
    self.resultError = nil;
    self.responseCode = -1;
    self.receivedData = [NSMutableData data];
    
    NSURLSessionConfiguration *config
    = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSessionDataTask *task;
    if (self.isDelegateSelf)    {
        self.session
        = [NSURLSession sessionWithConfiguration: config
                                        delegate: self
                                   delegateQueue: nil];
        task = [self.session dataTaskWithURL: self.currentURL];
    } else {
        void(^comleteH)(NSData *, NSURLResponse *, NSError *)
        = ^(NSData *data, NSURLResponse *response, NSError *error){
#ifdef DEBUG
            NSLog(@"%s", __FUNCTION__);
#endif
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
            self.responseCode = httpRes.statusCode;
            self.resultError = error;
            self.resultString = [[NSString alloc]initWithData: data
                                                     encoding: NSUTF8StringEncoding];;
#ifdef DEBUG
            NSInteger topLength = data.length > 20 ? 20 :  data.length;
            NSLog(@"[data] (%d)%@...", data.length, [self.resultString substringToIndex: topLength]);
            NSLog(@"[response] %@", response);
            NSLog(@"[error] %@", error);
#endif
            [self.session finishTasksAndInvalidate];
            [[NSOperationQueue mainQueue] addOperation: self.doOnComplete];
        };
        
        self.session = [NSURLSession sessionWithConfiguration: config];
        task = [self.session dataTaskWithURL: self.currentURL
                           completionHandler: comleteH];
    }
    self.countError = 0;
    [task resume];
#ifdef DEBUG
    NSLog( @"End of %s", __FUNCTION__ );
#endif
}

- (void)startDownload
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    
//    self.backId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler: ^(){}];
//    if ( self.backId == UIBackgroundTaskInvalid) {
//        NSLog(@"Can't do background.");
//    }
    
    self.resultError = nil;
    self.responseCode = -1;
    self.receivedData = [NSMutableData data];
    self.isDownload = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL: self.currentURL];
    
    NSURLSessionConfiguration *config
    = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier: @"mytask"];
//    config.sessionSendsLaunchEvents = true;
    
    NSURLSessionDownloadTask *task;
    self.session = [NSURLSession sessionWithConfiguration: config
                                                 delegate: self
                                            delegateQueue: nil];
    task = [self.session downloadTaskWithRequest: request];
    self.countError = 0;
    [task resume];
    
}

#pragma mark - NSURLSessionDelegate

- (void)       URLSession:(NSURLSession *)session
didBecomeInvalidWithError:(NSError *)error
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
    NSLog( @"[error] %@", error );
#endif
    
}

- (void) URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
  completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition,
                              NSURLCredential *credential))completionHandler
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
    NSString *authMethod = challenge.protectionSpace.authenticationMethod;
    NSLog( @"[authMethod]%@", authMethod );
#endif
    
    if ( [authMethod isEqualToString: NSURLAuthenticationMethodServerTrust] )  {
        SecTrustRef secTrustRef = challenge.protectionSpace.serverTrust;
        if (secTrustRef != NULL)    {
            SecTrustResultType result;
            OSErr er = SecTrustEvaluate( secTrustRef, &result );
            if ( er != noErr)  {
                completionHandler(NSURLSessionAuthChallengeRejectProtectionSpace, nil);
            }
            if ( result == kSecTrustResultRecoverableTrustFailure ) {
                NSLog( @"---SecTrustResultRecoverableTrustFailure" );
            }
            NSLog( @"---Return YES" );
            NSURLCredential *credential = [NSURLCredential credentialForTrust: secTrustRef];
            //        [[challenge sender] useCredential: credential forAuthenticationChallenge: challenge];
            
            
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        }
    }
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.downloadCompletionHandler) {
        void (^completionHandler)() = appDelegate.downloadCompletionHandler;
        appDelegate.downloadCompletionHandler = nil;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler();
        }];
    }
}

#pragma mark - NSURLSessionTaskDelegate

- (void)  URLSession:(NSURLSession *)session
                task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
    NSLog( @"[error] %@", error );
#endif
    self.resultError = error;
    if ( ! self.isDownload )    {
        self.resultString = [[NSString alloc]initWithData: self.receivedData
                                                 encoding: NSUTF8StringEncoding];
    }
    [self.session finishTasksAndInvalidate];
//    [[NSOperationQueue mainQueue] addOperation: self.doOnComplete];
//    [[UIApplication sharedApplication] endBackgroundTask: self.backId];
}

- (void) URLSession:(NSURLSession *)session
               task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
  completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition,
                              NSURLCredential *credential))completionHandler
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    
    if (self.countError > 2)    {
        [session invalidateAndCancel];
        return;
    }
    self.countError++;
    
    NSString *authMethod = challenge.protectionSpace.authenticationMethod;
#ifdef DEBUG
    NSLog( @"[challenge]%@", challenge );
    NSLog( @"[protectionSpace]%@", challenge.protectionSpace );
    NSLog( @"[authMethod]%@", authMethod );
#endif
    if ( [authMethod isEqualToString: NSURLAuthenticationMethodDefault] )  {
        NSURLCredential *credential = [NSURLCredential credentialWithUser: self.username
                                                                 password: self.password
                                                              persistence: NSURLCredentialPersistenceNone];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

- (void)      URLSession:(NSURLSession *)session
                    task:(NSURLSessionTask *)task
         didSendBodyData:(int64_t)bytesSent
          totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream *bodyStream))completionHandler
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    
}

- (void)        URLSession:(NSURLSession *)session
                      task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
                newRequest:(NSURLRequest *)request
         completionHandler:(void (^)(NSURLRequest *))completionHandler
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
    self.responseCode = httpRes.statusCode;
    completionHandler(request);
}

#pragma mark - NSURLSessionDataDelegate

- (void)   URLSession:(NSURLSession *)session
             dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    
}
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
    NSLog( @"[data] %@", data );
#endif
    [self.receivedData appendData: data];
}
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog( @"HTTP Response Code = %ld", (long)httpResponse.statusCode );
#endif
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    completionHandler(nil);
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)       URLSession:(NSURLSession *)session
             downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
    NSLog( @"%@", location );
#endif
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *URLs = [fileManager URLsForDirectory: NSDocumentDirectory
                                        inDomains: NSUserDomainMask];
    NSString *originalFN = downloadTask.originalRequest.URL.lastPathComponent;
    NSURL *destinationURL = [URLs[0] URLByAppendingPathComponent: originalFN];
    NSError *error;
    [fileManager removeItemAtURL: destinationURL error: NULL];
    if ([fileManager copyItemAtURL: location
                             toURL: destinationURL
                             error: &error]) {
        self.resultError = error;
    }
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    
}

- (void)       URLSession:(NSURLSession *)session
             downloadTask:(NSURLSessionDownloadTask *)downloadTask
             didWriteData:(int64_t)bytesWritten
        totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
#ifdef DEBUG
    //    NSLog( @"%s %8lld %8lld %8lld", __FUNCTION__, bytesWritten, totalBytesWritten, totalBytesExpectedToWrite );
#endif
    NSLog(@"Dowloading %lld %%", totalBytesWritten * 100 / totalBytesExpectedToWrite);
    
}
@end
