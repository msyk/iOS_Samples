//
//  ViewController.m
//  5_ComTest
//
//  Created by Masayuki Nii on 2014/01/21.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"

#import "ComTestMod.h"
#import "Communication.h"

@interface ViewController ()

@property (strong, nonatomic) NSString *resultString;
@property (strong, nonatomic) NSOperationQueue *queue;
//@property (strong, nonatomic) NSBlockOperation *finishTask;
@property (strong, nonatomic) ComTestMod *ct;
@property (weak, nonatomic) IBOutlet UITextView *resultText;

- (IBAction)tapButton1:(id)sender;
- (IBAction)tapButton2:(id)sender;
- (IBAction)tapButton3:(id)sender;
- (IBAction)tapButton4:(id)sender;
- (IBAction)tapButton5:(id)sender;
- (IBAction)tapButton6:(id)sender;
- (IBAction)tapButton7:(id)sender;
- (IBAction)tapButton8:(id)sender;

-(NSString *)escape: (NSString *)str;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.queue = [[NSOperationQueue alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapButton1:(id)sender {
    self.resultString = @"- didn't set it -";
    self.resultText.text = @"";
    
    NSBlockOperation *finishTask = [NSBlockOperation blockOperationWithBlock: ^(){
#ifdef DEBUG
        NSLog( @"%s", __FUNCTION__ );
#endif
        self.resultText.text = self.resultString;
    }];
    
    NSURL *url = [NSURL URLWithString: @"http://zip2.cgis.biz/xml/zip.php?zn=1010021"];
//    NSURL *url = [NSURL URLWithString: @"http://abc.def.com"];
//    NSURL *url = [NSURL URLWithString: @"http://10.0.1.249"];
//    NSURL *url = [NSURL URLWithString: @"http://zip2.cgis.biz/xxxxx"];
    NSURLSessionConfiguration *config
    = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSession *session
    = [NSURLSession sessionWithConfiguration: config
                                    delegate: nil
                               delegateQueue: nil];
    NSURLSessionDataTask *task = [session dataTaskWithURL: url
                                        completionHandler: ^(NSData *data,
                                                             NSURLResponse *response,
                                                             NSError *error){
#ifdef DEBUG
                                            NSLog(@"%s dataTaskWithURL-completionHandler", __FUNCTION__);
                                            self.resultString = [[NSString alloc]initWithData: data
                                                                                     encoding: NSUTF8StringEncoding];
                                            NSInteger topLength = self.resultString.length > 20 ? 20 :  self.resultString.length;
                                            NSLog(@"[data] (%d)%@...", data.length, [self.resultString substringToIndex: topLength]);
                                            NSLog(@"[response] %@", response);
                                            NSLog(@"[error] %@", error);
                                            
                                            NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
                                            [mainQueue addOperation: finishTask];
                                            //    [finishTask main];
#endif
                                            [session finishTasksAndInvalidate];
                                        }];
    
    [task resume];
#ifdef DEBUG
    NSLog( @"End of %s", __FUNCTION__ );
#endif
    
}

- (IBAction)tapButton2:(id)sender {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSString *urlString = @"http://zip2.cgis.biz/xml/zip.php?zn=1010021";
    NSBlockOperation *finishTask = [NSBlockOperation blockOperationWithBlock: ^(){
        NSLog( @"%s", __FUNCTION__);
        NSLog( @" Thread: %@", [NSThread isMainThread] ? @"Main" : @"Not Main");
        self.resultText.text = [[NSString alloc] initWithData: self.ct.receivedData
                                                     encoding: NSUTF8StringEncoding];
    }];
    self.ct = [[ComTestMod alloc] initWithURL: [NSURL URLWithString: urlString]
                                    withQueue: self.queue
                               WithFinishProc: finishTask];
    [queue addOperation: self.ct];
}

#define URL_ESCAPE (CFStringRef)@"!*'();:@&=+$,/?%#[]"

-(NSString *)escape: (NSString *)str
{
    NSString *escapedStr = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes (NULL,
                                                 (__bridge CFStringRef)str,
                                                 NULL,
                                                 URL_ESCAPE,
                                                 kCFStringEncodingUTF8);
    return escapedStr;
}

#define ESCAPESTR @" !*'();:@&=+$,/?%#[]"

- (IBAction)tapButton3:(id)sender {
    self.resultString = @"- didn't set it -";
    self.resultText.text = @"";
    
    NSCharacterSet *escapeSet = [NSCharacterSet characterSetWithCharactersInString: ESCAPESTR];
    escapeSet = [escapeSet invertedSet];
    
    NSDictionary *body = @{@"name": @"新居雅行", @"special": @"music & talk + thinking = me"};
    
    NSMutableData *bodyData = [NSMutableData data];
    __block BOOL isFirstItem = YES;
    __block NSString *escaped;
    [body enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSString *data, BOOL *stop){
        if (! isFirstItem)    {
            [bodyData appendData: [@"&" dataUsingEncoding: NSUTF8StringEncoding]];
        }
        [bodyData appendData: [key dataUsingEncoding: NSUTF8StringEncoding]];
        [bodyData appendData: [@"=" dataUsingEncoding: NSUTF8StringEncoding]];
        escaped = [data stringByAddingPercentEncodingWithAllowedCharacters: escapeSet];
        [bodyData appendData: [escaped dataUsingEncoding: NSUTF8StringEncoding]];
        isFirstItem = NO;
    }];
    
    NSLog( @"%@", [[NSString alloc] initWithData: bodyData encoding: NSUTF8StringEncoding]);
    
//    NSCharacterSet *cset = [NSCharacterSet URLQueryAllowedCharacterSet];
//    for ( int i = 0 ; i<256;i++)    {
//        printf ("%2x:%1d ", i, [cset characterIsMember: i]);
//    }
//    
    NSBlockOperation *finishTask = [NSBlockOperation blockOperationWithBlock: ^(){
        self.resultText.text = self.resultString;
    }];
    
    NSURL *url = [NSURL URLWithString: @"http://msyk.net/ios/echoback.php?a=1&b=2"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    req.HTTPMethod = @"POST";
    [req          setValue: @"application/x-www-form-urlencoded"
        forHTTPHeaderField: @"Content-Type"];
    [req          setValue: [NSString stringWithFormat:@"%d", [bodyData length]]
        forHTTPHeaderField: @"Content-Length"];
    req.HTTPBody = bodyData;
    
    
    NSURLSessionConfiguration *config
    = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSession *session
    = [NSURLSession sessionWithConfiguration: config
                                    delegate: nil
                               delegateQueue: nil];
    NSURLSessionDataTask *task = [session dataTaskWithRequest: req
                                            completionHandler:
        ^(NSData *data,
          NSURLResponse *response,
          NSError *error){
                self.resultString = [[NSString alloc]initWithData: data
                                                         encoding: NSUTF8StringEncoding];
                NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
                [mainQueue addOperation: finishTask];
                [session finishTasksAndInvalidate];
        }];
    
    [task resume];
}

- (IBAction)tapButton4:(id)sender {
    NSURL *url = [NSURL URLWithString: @"https://coolnotify.com/"];
    Communication *c = [[Communication alloc] initWithURL: url];
//    [c delegateToSelf];
    [c setCompletionBlock: [NSBlockOperation blockOperationWithBlock: ^(){
        self.resultText.text = c.resultString;
    }]];
    [c startCommunication];

}

- (IBAction)tapButton5:(id)sender {
    NSURL *url = [NSURL URLWithString: @"https://server.msyk.net/authtest/"];
    Communication *c = [[Communication alloc] initWithURL: url];
    [c delegateToSelf];
    [c setUserName: @"test" andPasword: @"abcd"];
    [c setCompletionBlock: [NSBlockOperation blockOperationWithBlock: ^(){
        self.resultText.text = c.resultString;
    }]];
    [c startCommunication];
}

- (IBAction)tapButton6:(id)sender {
    NSURL *url = [NSURL URLWithString: @"https://server.msyk.net/10m.txt"];
    Communication *c = [[Communication alloc] initWithURL: url];
    [c delegateToSelf];
    [c setCompletionBlock: [NSBlockOperation blockOperationWithBlock: ^(){
        NSLog(@"%s", __FUNCTION__);
    }]];
    [c startDownload];
}

- (IBAction)tapButton7:(id)sender {
}

- (IBAction)tapButton8:(id)sender {
}
@end

/*
 - (void)testHTTPWithoutDelegate
 {
 NSURL *url = [NSURL URLWithString: @"http://msyk.net"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 2013-10-09 01:26:17.317 ComTest7[7259:70b] -[Communication startCommunication]
 2013-10-09 01:26:17.318 ComTest7[7259:70b] Is main thread ? YES
 2013-10-09 01:26:17.334 ComTest7[7259:70b] End of -[Communication startCommunication]
 2013-10-09 01:26:17.340 ComTest7[7259:3d07] __35-[Communication startCommunication]_block_invoke dataTaskWithURL-completionHandler
 2013-10-09 01:26:17.340 ComTest7[7259:3d07] Is main thread ? NO
 2013-10-09 01:26:17.341 ComTest7[7259:3d07] [data] (12145)<html lang="ja">
 <h...
 2013-10-09 01:26:17.341 ComTest7[7259:3d07] [response] <NSHTTPURLResponse: 0x8baa900> { URL: http://msyk.net/ } { status code: 200, headers {
 "Accept-Ranges" = bytes;
 Connection = close;
 "Content-Encoding" = gzip;
 "Content-Length" = 3127;
 "Content-Type" = "text/html";
 Date = "Sat, 28 Sep 2013 17:40:24 GMT";
 Etag = "\"47aeae-2f71-510d0746\"";
 "Last-Modified" = "Sat, 02 Feb 2013 12:32:06 GMT";
 Server = Apache;
 } }
 2013-10-09 01:26:17.342 ComTest7[7259:3d07] [error] (null)
 */
/*
 - (void)testHTTPWithDelegate
 {
 NSURL *url = [NSURL URLWithString: @"http://msyk.net"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c delegateToSelf];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 2013-10-09 01:29:15.704 ComTest7[7440:70b] -[Communication startCommunication]
 2013-10-09 01:29:15.705 ComTest7[7440:70b] Is main thread ? YES
 2013-10-09 01:29:15.720 ComTest7[7440:70b] End of -[Communication startCommunication]
 2013-10-09 01:29:15.723 ComTest7[7440:f03] -[Communication URLSession:dataTask:didReceiveResponse:completionHandler:]
 2013-10-09 01:29:15.724 ComTest7[7440:f03] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-09 01:29:15.724 ComTest7[7440:f03] -[Communication URLSession:task:didCompleteWithError:]
 */
/*
 - (void)testWrongFileWithoutDelegate
 {
 NSURL *url = [NSURL URLWithString: @"http://msyk.net/xxxx.html"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 2013-10-14 13:37:10.157 ComTest7[14285:70b] -[Communication startCommunication]
 2013-10-14 13:37:10.158 ComTest7[14285:70b] Is main thread ? YES
 2013-10-14 13:37:10.177 ComTest7[14285:70b] End of -[Communication startCommunication]
 2013-10-14 13:37:10.243 ComTest7[14285:f03] __35-[Communication startCommunication]_block_invoke dataTaskWithURL-completionHandler
 2013-10-14 13:37:10.244 ComTest7[14285:f03] Is main thread ? NO
 2013-10-14 13:37:10.244 ComTest7[14285:f03] [data] (13)404 Not Found...
 2013-10-14 13:37:10.244 ComTest7[14285:f03] [response] <NSHTTPURLResponse: 0x8d74810> { URL: http://msyk.net/xxxx.html } { status code: 404, headers {
 Connection = close;
 "Content-Type" = "text/html; charset=iso-8859-1";
 Date = "Mon, 14 Oct 2013 04:37:10 GMT";
 Server = Apache;
 "Transfer-Encoding" = Identity;
 } }
 2013-10-14 13:37:10.245 ComTest7[14285:f03] [error] (null)
 */
/*
 - (void)testWrongFileWithDelegate
 {
 NSURL *url = [NSURL URLWithString: @"http://msyk.net/xxxx.html"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c delegateToSelf];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 2013-10-14 13:38:03.463 ComTest7[14354:70b] -[Communication startCommunication]
 2013-10-14 13:38:03.464 ComTest7[14354:70b] Is main thread ? YES
 2013-10-14 13:38:03.476 ComTest7[14354:70b] End of -[Communication startCommunication]
 2013-10-14 13:38:03.517 ComTest7[14354:3d07] -[Communication URLSession:dataTask:didReceiveResponse:completionHandler:]
 2013-10-14 13:38:03.518 ComTest7[14354:3d07] HTTP Response Code = 404
 2013-10-14 13:38:03.518 ComTest7[14354:3d07] -[Communication URLSession:dataTask:willCacheResponse:completionHandler:]
 2013-10-14 13:38:03.519 ComTest7[14354:3d07] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-14 13:38:03.519 ComTest7[14354:3d07] [data] <34303420 4e6f7420 466f756e 64>
 2013-10-14 13:38:03.519 ComTest7[14354:3d07] -[Communication URLSession:task:didCompleteWithError:]
 2013-10-14 13:38:03.520 ComTest7[14354:3d07] [error] (null)
 */
/*
 - (void)testWrongURLWithoutDelegate
 {
 NSURL *url = [NSURL URLWithString: @"http://msyk.netxxxx"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 2013-10-09 01:30:56.615 ComTest7[7530:70b] -[Communication startCommunication]
 2013-10-09 01:30:56.616 ComTest7[7530:70b] Is main thread ? YES
 2013-10-09 01:30:56.616 ComTest7[7530:70b] End of -[Communication startCommunication]
 2013-10-09 01:30:56.631 ComTest7[7530:4b1b] __35-[Communication startCommunication]_block_invoke dataTaskWithURL-completionHandler
 2013-10-09 01:30:56.631 ComTest7[7530:4b1b] Is main thread ? NO
 2013-10-09 01:30:56.631 ComTest7[7530:4b1b] [data] (0)...
 2013-10-09 01:30:56.631 ComTest7[7530:4b1b] [response] (null)
 2013-10-09 01:30:56.632 ComTest7[7530:4b1b] [error] Error Domain=NSURLErrorDomain Code=-1003 "A server with the specified hostname could not be found." UserInfo=0x8c28200 {NSErrorFailingURLStringKey=http://msyk.netxxxx, NSErrorFailingURLKey=http://msyk.netxxxx, NSLocalizedDescription=A server with the specified hostname could not be found., NSUnderlyingError=0x8c26e90 "A server with the specified hostname could not be found."}
 */
/*
 - (void)testWrongURLWithDelegate
 {
 NSURL *url = [NSURL URLWithString: @"http://msyk.netxxxxx"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c delegateToSelf];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 2013-10-09 01:32:44.271 ComTest7[7640:70b] -[Communication startCommunication]
 2013-10-09 01:32:44.272 ComTest7[7640:70b] Is main thread ? YES
 2013-10-09 01:32:44.273 ComTest7[7640:70b] End of -[Communication startCommunication]
 2013-10-09 01:32:44.292 ComTest7[7640:3e0f] -[Communication URLSession:task:didCompleteWithError:]
 2013-10-09 01:32:44.293 ComTest7[7640:3e0f] [error] Error Domain=NSURLErrorDomain Code=-1003 "A server with the specified hostname could not be found." UserInfo=0xdb4fe70 {NSErrorFailingURLStringKey=http://msyk.netxxxxx, NSErrorFailingURLKey=http://msyk.netxxxxx, NSLocalizedDescription=A server with the specified hostname could not be found., NSUnderlyingError=0x8d59160 "A server with the specified hostname could not be found."}
 */

/*
 - (void)testHTTPSWithoutDelegate
 {
 NSURL *url = [NSURL URLWithString: @"https://server.msyk.net"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 2013-10-09 01:34:31.913 ComTest7[7745:70b] -[Communication startCommunication]
 2013-10-09 01:34:31.915 ComTest7[7745:70b] Is main thread ? YES
 2013-10-09 01:34:31.926 ComTest7[7745:70b] End of -[Communication startCommunication]
 2013-10-09 01:34:31.930 ComTest7[7745:3d07] __35-[Communication startCommunication]_block_invoke dataTaskWithURL-completionHandler
 2013-10-09 01:34:31.931 ComTest7[7745:3d07] Is main thread ? NO
 2013-10-09 01:34:31.931 ComTest7[7745:3d07] [data] (7327)<!DOCTYPE html>
 <htm...
 2013-10-09 01:34:31.932 ComTest7[7745:3d07] [response] <NSHTTPURLResponse: 0x8b0b200> { URL: https://server.msyk.net/ } { status code: 200, headers {
 "Accept-Ranges" = bytes;
 Connection = close;
 "Content-Length" = 7327;
 "Content-Type" = "text/html; charset=UTF-8";
 Date = "Tue, 08 Oct 2013 15:12:00 GMT";
 Etag = "\"34073a-1c9f-4e50d199e8f80\"";
 "Last-Modified" = "Thu, 29 Aug 2013 02:45:34 GMT";
 Server = "Apache/2.2.15 (CentOS)";
 } }
 2013-10-09 01:34:31.932 ComTest7[7745:3d07] [error] (null)
 
 
 
 - (void)testHTTPSWithDelegate
 {
 NSURL *url = [NSURL URLWithString: @"https://server.msyk.net"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c delegateToSelf];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
 /*
 2013-10-09 01:35:03.866 ComTest7[7780:70b] -[Communication startCommunication]
 2013-10-09 01:35:03.868 ComTest7[7780:70b] Is main thread ? YES
 2013-10-09 01:35:03.881 ComTest7[7780:70b] End of -[Communication startCommunication]
 2013-10-09 01:35:03.886 ComTest7[7780:f03] -[Communication URLSession:dataTask:didReceiveResponse:completionHandler:]
 2013-10-09 01:35:03.886 ComTest7[7780:3d07] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-09 01:35:03.887 ComTest7[7780:3d07] -[Communication URLSession:task:didCompleteWithError:]
 2013-10-09 01:35:03.888 ComTest7[7780:3d07] [error] (null)
 
 ****** Add Trust Code
 
 2013-10-09 02:21:01.919 ComTest7[10290:70b] -[Communication startCommunication]
 2013-10-09 02:21:01.920 ComTest7[10290:70b] Is main thread ? YES
 2013-10-09 02:21:01.933 ComTest7[10290:70b] End of -[Communication startCommunication]
 2013-10-09 02:21:01.939 ComTest7[10290:f03] -[Communication URLSession:dataTask:didReceiveResponse:completionHandler:]
 2013-10-09 02:21:01.939 ComTest7[10290:f03] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-09 02:21:01.941 ComTest7[10290:f03] [data] <3c21444f 43545950 45206874 6d6c3e0d 3c68746d 6c3e0d3c 68656164 3e0d2020 20203c6d
 2013-10-09 02:21:01.951 ComTest7[10290:f03] -[Communication URLSession:task:didCompleteWithError:]
 2013-10-09 02:21:01.952 ComTest7[10290:f03] [error] (null)
 
 
 */
/*
 - (void)testRedirectWithoutDelegate
 {
 NSURL *url = [NSURL URLWithString: @"http://msyk.net/yubin"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 2013-10-09 01:44:16.718 ComTest7[8299:70b] -[Communication startCommunication]
 2013-10-09 01:44:16.719 ComTest7[8299:70b] Is main thread ? YES
 2013-10-09 01:44:16.731 ComTest7[8299:70b] End of -[Communication startCommunication]
 2013-10-09 01:44:16.863 ComTest7[8299:3d07] __35-[Communication startCommunication]_block_invoke dataTaskWithURL-completionHandler
 2013-10-09 01:44:16.863 ComTest7[8299:3d07] Is main thread ? NO
 2013-10-09 01:44:16.863 ComTest7[8299:3d07] [data] (12118)<html lang="ja">
 
 <h...
 2013-10-09 01:44:16.864 ComTest7[8299:3d07] [response] <NSHTTPURLResponse: 0x8bb1810> { URL: http://yubin.msyk.net/yubin/ } { status code: 200, headers {
 "Accept-Ranges" = bytes;
 Connection = close;
 "Content-Length" = 12118;
 "Content-Type" = "text/html; charset=UTF-8";
 Date = "Tue, 08 Oct 2013 16:44:16 GMT";
 Etag = "\"340605-2f56-4cad98fcaf700\"";
 "Last-Modified" = "Sat, 29 Sep 2012 16:21:16 GMT";
 Server = "Apache/2.2.15 (CentOS)";
 } }
 2013-10-09 01:44:16.864 ComTest7[8299:3d07] [error] (null)
 
 */
/*
 - (void)testRedirectWithDelegate
 {
 NSURL *url = [NSURL URLWithString: @"http://msyk.net/yubin"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c delegateToSelf];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 2013-10-09 01:43:38.673 ComTest7[8265:70b] -[Communication startCommunication]
 2013-10-09 01:43:38.674 ComTest7[8265:70b] Is main thread ? YES
 2013-10-09 01:43:38.687 ComTest7[8265:70b] End of -[Communication startCommunication]
 2013-10-09 01:43:38.725 ComTest7[8265:f03] -[Communication URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:]
 2013-10-09 01:43:38.760 ComTest7[8265:f03] -[Communication URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:]
 2013-10-09 01:43:38.814 ComTest7[8265:3d07] -[Communication URLSession:dataTask:didReceiveResponse:completionHandler:]
 2013-10-09 01:43:38.815 ComTest7[8265:3d07] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-09 01:43:38.815 ComTest7[8265:3d07] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-09 01:43:38.816 ComTest7[8265:3d07] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-09 01:43:38.816 ComTest7[8265:4307] -[Communication URLSession:dataTask:willCacheResponse:completionHandler:]
 
 */
/*
 - (void)testInvalidCertWithoutDelegate
 {
 NSURL *url = [NSURL URLWithString: @"https://coolnotify.com/"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 2013-10-09 01:49:47.343 ComTest7[8597:70b] -[Communication startCommunication]
 2013-10-09 01:49:47.344 ComTest7[8597:70b] Is main thread ? YES
 2013-10-09 01:49:47.345 ComTest7[8597:70b] End of -[Communication startCommunication]
 2013-10-09 01:49:47.360 ComTest7[8597:3703] NSURLConnection/CFURLConnection HTTP load failed (kCFStreamErrorDomainSSL, -9813)
 2013-10-09 01:49:47.362 ComTest7[8597:5017] __35-[Communication startCommunication]_block_invoke dataTaskWithURL-completionHandler
 2013-10-09 01:49:47.362 ComTest7[8597:5017] Is main thread ? NO
 2013-10-09 01:49:47.362 ComTest7[8597:5017] [data] (0)...
 2013-10-09 01:49:47.362 ComTest7[8597:5017] [response] (null)
 2013-10-09 01:49:47.363 ComTest7[8597:5017] [error] Error Domain=NSURLErrorDomain Code=-1202 "The certificate for this server is invalid. You might be connecting to a server that is pretending to be “coolnotify.com” which could put your confidential information at risk." UserInfo=0x8d909a0 {NSErrorFailingURLStringKey=https://coolnotify.com/, NSLocalizedRecoverySuggestion=Would you like to connect to the server anyway?, NSErrorFailingURLKey=https://coolnotify.com/, NSLocalizedDescription=The certificate for this server is invalid. You might be connecting to a server that is pretending to be “coolnotify.com” which could put your confidential information at risk., NSUnderlyingError=0xbfa8d40 "The certificate for this server is invalid. You might be connecting to a server that is pretending to be “coolnotify.com” which could put your confidential information at risk.", NSURLErrorFailingURLPeerTrustErrorKey=<SecTrustRef: 0x8d8f160>}
 
 */
/*
 - (void)testInvalidCertWithDelegate
 {
 NSURL *url = [NSURL URLWithString: @"https://coolnotify.com/"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c delegateToSelf];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
/*
 
 - (void) URLSession:(NSURLSession *)session
 task:(NSURLSessionTask *)task
 didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition,
 NSURLCredential *credential))completionHandler
 {
 #ifdef DEBUG
 NSLog( @"%s", __FUNCTION__ );
 #endif
 completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
 }
 
 
 2013-10-09 01:57:58.046 ComTest7[9053:70b] -[Communication startCommunication]
 2013-10-09 01:57:58.047 ComTest7[9053:70b] Is main thread ? YES
 2013-10-09 01:57:58.066 ComTest7[9053:70b] End of -[Communication startCommunication]
 2013-10-09 01:57:58.091 ComTest7[9053:f03] -[Communication URLSession:didReceiveChallenge:completionHandler:]
 2013-10-09 01:57:58.097 ComTest7[9053:3703] NSURLConnection/CFURLConnection HTTP load failed (kCFStreamErrorDomainSSL, -9813)
 2013-10-09 01:57:58.099 ComTest7[9053:4307] -[Communication URLSession:task:didCompleteWithError:]
 2013-10-09 01:57:58.099 ComTest7[9053:4307] [error] Error Domain=NSURLErrorDomain Code=-1202 "The certificate for this server is invalid. You might be connecting to a server that is pretending to be “coolnotify.com” which could put your confidential information at risk." UserInfo=0x8de27b0 {NSErrorFailingURLStringKey=https://coolnotify.com/, NSLocalizedRecoverySuggestion=Would you like to connect to the server anyway?, NSErrorFailingURLKey=https://coolnotify.com/, NSLocalizedDescription=The certificate for this server is invalid. You might be connecting to a server that is pretending to be “coolnotify.com” which could put your confidential information at risk., NSUnderlyingError=0x8ddfd50 "The certificate for this server is invalid. You might be connecting to a server that is pretending to be “coolnotify.com” which could put your confidential information at risk.", NSURLErrorFailingURLPeerTrustErrorKey=<SecTrustRef: 0x8ddfaf0>}
 
 ******* Add trust code
 
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
 [[challenge sender] useCredential: credential forAuthenticationChallenge: challenge];
 
 
 completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
 }
 }
 }
 
 2013-10-09 02:21:01.951 ComTest7[10290:f03] -[Communication URLSession:task:didCompleteWithError:]
 2013-10-09 02:21:01.952 ComTest7[10290:f03] [error] (null)
 Test Case '-[ComTest7Tests testHTTPSWithDelegate]' passed (10.015 seconds).
 Test Case '-[ComTest7Tests testInvalidCertWithDelegate]' started.
 2013-10-09 02:21:11.935 ComTest7[10290:70b] -[Communication startCommunication]
 2013-10-09 02:21:11.936 ComTest7[10290:70b] Is main thread ? YES
 2013-10-09 02:21:11.937 ComTest7[10290:70b] End of -[Communication startCommunication]
 2013-10-09 02:21:11.947 ComTest7[10290:4a07] -[Communication URLSession:didReceiveChallenge:completionHandler:]
 2013-10-09 02:21:11.947 ComTest7[10290:4a07] [authMethod]NSURLAuthenticationMethodServerTrust
 2013-10-09 02:21:11.952 ComTest7[10290:4a07] ---SecTrustResultRecoverableTrustFailure
 2013-10-09 02:21:11.952 ComTest7[10290:4a07] ---Return YES
 2013-10-09 02:21:11.983 ComTest7[10290:4a07] -[Communication URLSession:dataTask:didReceiveResponse:completionHandler:]
 2013-10-09 02:21:11.983 ComTest7[10290:4b17] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-09 02:21:11.985 ComTest7[10290:4b17] [data] <3c68746d 6c3e0a3c 68656164 3e0a3c74 69746c65 3e436f6f
 2013-10-09 02:21:12.003 ComTest7[10290:4b17] -[Communication URLSession:dataTask:willCacheResponse:completionHandler:]
 2013-10-09 02:21:12.004 ComTest7[10290:4d07] -[Communication URLSession:task:didCompleteWithError:]
 2013-10-09 02:21:12.004 ComTest7[10290:4d07] [error] (null)
 
 
 
 
 - (void)testAuthWithDelegate
 {
 NSURL *url = [NSURL URLWithString: @"http://msyk.dyndns.orgx/xadminserver/admin/"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c delegateToSelf];
 [c setUserName: @"admin" andPasword: @"abc"];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */
 /*
 ****** No care
 
 2013-10-09 02:37:57.519 ComTest7[11167:70b] -[Communication startCommunication]
 2013-10-09 02:37:57.520 ComTest7[11167:70b] Is main thread ? YES
 2013-10-09 02:37:57.534 ComTest7[11167:70b] End of -[Communication startCommunication]
 2013-10-09 02:37:57.550 ComTest7[11167:4703] -[Communication URLSession:task:didReceiveChallenge:completionHandler:]
 2013-10-09 02:37:57.555 ComTest7[11167:4307] -[Communication URLSession:dataTask:didReceiveResponse:completionHandler:]
 2013-10-09 02:37:57.555 ComTest7[11167:4307] HTTP Response Code = 401
 2013-10-09 02:37:57.555 ComTest7[11167:4307] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-09 02:37:57.556 ComTest7[11167:4307] [data] <3c21444f 43545950 45204854 4d4c2050 55424c49 4320222d 2f2f4945 54462f2f 44544420 48544d4c 20322e30 2f2f454e 223e0a3c 68746d6c 3e3c6865 61643e0a 3c746974 6c653e34 30312041 7574686f 72697a61 74696f6e 20526571 75697265 643c2f74 69746c65 3e0a3c2f 68656164 3e3c626f 64793e0a 3c68313e 41757468 6f72697a 6174696f 6e205265 71756972 65643c2f 68313e0a 3c703e54 68697320 73657276 65722063 6f756c64 206e6f74 20766572 69667920 74686174 20796f75 0a617265 20617574 686f7269 7a656420 746f2061 63636573 73207468 6520646f 63756d65 6e740a72 65717565 73746564 2e202045 69746865 7220796f 75207375 70706c69 65642074 68652077 726f6e67 0a637265 64656e74 69616c73 2028652e 672e2c20 62616420 70617373 776f7264 292c206f 7220796f 75720a62 726f7773 65722064 6f65736e 27742075 6e646572 7374616e 6420686f 7720746f 20737570 706c790a 74686520 63726564 656e7469 616c7320 72657175 69726564 2e3c2f70 3e0a3c68 723e0a3c 61646472 6573733e 41706163 68652f32 2e322e32 34202855 6e697829 20444156 2f32206d 6f645f66 61737463 67692f32 2e342e36 206d6f64 5f73736c 2f322e32 2e323420 4f70656e 53534c2f 302e392e 38792053 65727665 72206174 206d7379 6b2e6479 6e646e73 2e6f7267 20506f72 74203830 3c2f6164 64726573 733e0a3c 2f626f64 793e3c2f 68746d6c 3e0a>
 2013-10-09 02:37:57.557 ComTest7[11167:4307] -[Communication URLSession:task:didCompleteWithError:]
 2013-10-09 02:37:57.557 ComTest7[11167:4307] [error] (null)
 
 *** Add delegate of the task
 
 2013-10-09 02:43:25.037 ComTest7[11497:70b] -[Communication startCommunication]
 2013-10-09 02:43:25.039 ComTest7[11497:70b] Is main thread ? YES
 2013-10-09 02:43:25.053 ComTest7[11497:70b] End of -[Communication startCommunication]
 2013-10-09 02:43:25.068 ComTest7[11497:f03] -[Communication URLSession:task:didReceiveChallenge:completionHandler:]
 2013-10-09 02:43:25.068 ComTest7[11497:f03] [authMethod]NSURLAuthenticationMethodDefault
 2013-10-09 02:43:25.128 ComTest7[11497:3207] -[Communication URLSession:dataTask:didReceiveResponse:completionHandler:]
 2013-10-09 02:43:25.128 ComTest7[11497:3207] HTTP Response Code = 200
 2013-10-09 02:43:25.129 ComTest7[11497:3207] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-09 02:43:25.129 ComTest7[11497:3207] -[Communication URLSession:dataTask:didReceiveData:]
 2013-10-09 02:43:25.140 ComTest7[11497:3207] -[Communication URLSession:dataTask:willCacheResponse:completionHandler:]
 2013-10-09 02:43:25.140 ComTest7[11497:4703] -[Communication URLSession:task:didCompleteWithError:]
 2013-10-09 02:43:25.141 ComTest7[11497:4703] [error] (null)
 
 */
/* さすがにこれはできない
 - (void)testLoginPageWithDelegate
 {
 NSURL *url = [NSURL URLWithString: @"http://edu.msyk.net/moodle/login/index.php"];
 Communication *c = [[Communication alloc] initWithURL: url];
 [c delegateToSelf];
 //    [c setUserName: @"admin" andPasword: @"abc"];
 [c startCommunication];
 XCTAssertNotNil(c, @"Really?");
 sleep(10);
 }
 */



/*
 
 - (void)test1
 {
 NSString *urlString = @"http://msyk.net/index.html";
 NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock: ^(){
 NSLog( @"%s", __FUNCTION__);
 NSLog( @" Thread: %@", [NSThread isMainThread] ? @"Main" : @"Not Main");
 
 }];
 ComTest *ct = [[ComTest alloc] initWithURL: [NSURL URLWithString: urlString]
 WithFinishProc: bo];
 [ct start];
 
 while (! [ct isFinished] )   {
 [[NSRunLoop currentRunLoop] runUntilDate: [NSDate date]];
 }
 STAssertTrue(ct.receivedData.length > 0, @"should download any data.");
 }
 */
 /*
 - (void)test2
 {
 NSOperationQueue *queue = [[NSOperationQueue alloc]init];
 
 NSString *urlString = @"http://msyk.net/index.html";
 NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock: ^(){
 NSLog( @"%s", __FUNCTION__);
 NSLog( @" Thread: %@", [NSThread isMainThread] ? @"Main" : @"Not Main");
 
 }];
 ComTest *ct = [[ComTest alloc] initWithURL: [NSURL URLWithString: urlString]
 WithFinishProc: bo];
 [queue addOperation: ct];
 while (! [ct isFinished] )   {
 [[NSRunLoop currentRunLoop] runUntilDate: [NSDate date]];
 }
 NSLog( @"End of the Loop, Thread: %@", [NSThread isMainThread] ? @"Main" : @"Not Main");
 STAssertTrue(ct.receivedData.length > 0, @"should download any data.");
 }
 */
/*
 - (void)test3
 {
 NSOperationQueue *queue = [[NSOperationQueue alloc]init];
 
 NSString *urlString = @"http://msyk.net/index.html";
 NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock: ^(){
 NSLog( @"%s", __FUNCTION__);
 NSLog( @" Thread: %@", [NSThread isMainThread] ? @"Main" : @"Not Main");
 
 }];
 ComTestMod *ct = [[ComTestMod alloc] initWithURL: [NSURL URLWithString: urlString]
 withQueue: queue
 WithFinishProc: bo];
 [queue addOperation: ct];
 while (! [ct isFinished] )   {
 [[NSRunLoop currentRunLoop] runUntilDate: [NSDate date]];
 }
 NSLog( @"End of the Loop, Thread: %@", [NSThread isMainThread] ? @"Main" : @"Not Main");
 STAssertTrue(ct.receivedData.length > 0, @"should download any data.");
 }
 */

