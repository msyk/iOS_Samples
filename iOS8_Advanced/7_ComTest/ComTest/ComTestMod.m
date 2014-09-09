//
//  ComTest.m
//  ComTest
//
//  Created by Masayuki Nii on 2013/08/31.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "ComTestMod.h"

@interface ComTestMod()

@property (nonatomic) BOOL isExecuting;
@property (nonatomic) BOOL isFinished;

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSBlockOperation *onFinishProc;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableURLRequest *request;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ComTestMod

- (BOOL)isConcurrent
{
    return YES;
}

- (id) init
{
    if ( (self = [super init]) )    {
        self.queue = nil;
    }
    return self;
}

-(id) initWithURL: (NSURL *)url
        withQueue: (NSOperationQueue *)queue
   WithFinishProc: (NSBlockOperation *)finishProc;
{
#ifdef DEBUG
    NSLog( @"[Main=%@]%s", [NSThread isMainThread] ? @"YES" : @"NO ", __FUNCTION__ );
#endif
    
    if (( self = [self init] ))    {
        self.url = url;
        
#ifdef DEBUG
        NSLog( @"URL=%@", self.url);
#endif
        
        self.queue = queue;
        self.onFinishProc = finishProc;
        self.communicationError = nil;
        /*
         * NSURLConnection instanciate moved to here. Then doesn't start immediately.
         */
        self.request = [NSMutableURLRequest requestWithURL: self.url];
        self.connection = [[NSURLConnection alloc] initWithRequest: self.request
                                                          delegate: self
                                                  startImmediately: NO];
        /*
         * NSURLConnection's this method is important.
         */
        [self.connection setDelegateQueue: self.queue];
    }
    return self;
}

- (void)start
{
#ifdef DEBUG
    NSLog( @"[Main=%@]%s", [NSThread isMainThread] ? @"YES" : @"NO ", __FUNCTION__ );
#endif
    /*
     * Check first.
     */
    if (self.connection == nil) {
        [self finish];
    }
    
    self.receivedData = [NSMutableData data];
    self.responseCode = 0;
    self.communicationError = nil;
    
    
#ifdef DEBUG
    NSLog( @"Connect to: %@", self.url );
#endif
    
    [self willChangeValueForKey:@"isExecuting"];
    self.isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    /*
     * The start method should be called.
     */
    [self.connection start];
    
    /*
     * The one of the way to be called back on the non-main thread is below.
     * But it doesn't need after iOS 5/Lion.
     */
    // http://www.cocoaintheshell.com/2011/04/nsurlconnection-synchronous-asynchronous/
    //    NSPort* port = [NSPort port];
    //    NSRunLoop* runLoop = [NSRunLoop currentRunLoop]; // Get the runloop
    //    [runLoop addPort:port forMode: NSDefaultRunLoopMode];
    //    [self.connection scheduleInRunLoop: runLoop
    //                               forMode: NSDefaultRunLoopMode];
    // [self.connection start];
    //    [runLoop run];
#ifdef DEBUG
    NSLog( @"Finish: %s", __FUNCTION__ );
#endif
}

- (void)finish
{
#ifdef DEBUG
    NSLog( @"[Main=%@]%s", [NSThread isMainThread] ? @"YES" : @"NO ", __FUNCTION__ );
#endif
    
    self.connection = nil;
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    self.isExecuting = NO;
    self.isFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
#ifdef DEBUG
    NSLog( @"[Main=%@]%s", [NSThread isMainThread] ? @"YES" : @"NO ", __FUNCTION__ );
#endif
    
    self.responseCode = ((NSHTTPURLResponse *)response).statusCode;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
#ifdef DEBUG
    NSLog( @"[Main=%@]%s", [NSThread isMainThread] ? @"YES" : @"NO ", __FUNCTION__ );
#endif
    
    [self.receivedData appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
#ifdef DEBUG
    NSLog( @"[Main=%@]%s", [NSThread isMainThread] ? @"YES" : @"NO ", __FUNCTION__ );
#endif
    
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [mainQueue addOperation: self.onFinishProc];
    [self finish];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
#ifdef DEBUG
    NSLog( @"[Main=%@]%s", [NSThread isMainThread] ? @"YES" : @"NO ", __FUNCTION__ );
#endif
    
    self.communicationError = error;
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [mainQueue addOperation: self.onFinishProc];
    [self finish];
}

@end
