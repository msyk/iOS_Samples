//
//  ViewController.m
//  4_3_WebView
//
//  Created by Masayuki Nii on 2014/01/18.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) WKWebView *webView;

-(IBAction)tapButton1:(id) sender;
-(IBAction)tapButton2:(id) sender;

@end

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.userContentController = [[WKUserContentController alloc]init];
    [config.userContentController addScriptMessageHandler: self name: @"say1"];
    NSString *startJS = @"alert('No!');";
    WKUserScript *userScript
        = [[WKUserScript alloc] initWithSource: startJS
                                 injectionTime: WKUserScriptInjectionTimeAtDocumentStart
                              forMainFrameOnly: YES];
    [config.userContentController addUserScript: userScript];
    
    self.webView = [[WKWebView alloc] initWithFrame: self.view.bounds
                                      configuration: config];
    [self.view addSubview: self.webView];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    [self.webView setTranslatesAutoresizingMaskIntoConstraints: NO];
    NSLayoutConstraint *leading
    = [NSLayoutConstraint constraintWithItem: self.webView
                                   attribute: NSLayoutAttributeLeading
                                   relatedBy: NSLayoutRelationEqual
                                      toItem: self.view
                                   attribute: NSLayoutAttributeLeading
                                  multiplier:1.0
                                    constant:0.0];
    NSLayoutConstraint *trailing
    = [NSLayoutConstraint constraintWithItem: self.webView
                                   attribute: NSLayoutAttributeTrailing
                                   relatedBy: NSLayoutRelationEqual
                                      toItem: self.view
                                   attribute: NSLayoutAttributeTrailing
                                  multiplier: 1.0
                                    constant: 0.0];
    NSLayoutConstraint *top
    = [NSLayoutConstraint constraintWithItem: self.webView
                                   attribute: NSLayoutAttributeTop
                                   relatedBy: NSLayoutRelationEqual
                                      toItem: self.topLayoutGuide
                                   attribute: NSLayoutAttributeBottom
                                  multiplier: 1.0
                                    constant: 0.0];
    NSLayoutConstraint *bottom
    = [NSLayoutConstraint constraintWithItem: self.webView
                                   attribute: NSLayoutAttributeBottom
                                   relatedBy: NSLayoutRelationEqual
                                      toItem: self.bottomLayoutGuide
                                   attribute: NSLayoutAttributeTop
                                  multiplier: 1.0
                                    constant: 0.0];
    [self.view addConstraints: @[leading, trailing, top, bottom]];
    
    
    NSURL *baseURL = [[NSBundle mainBundle] resourceURL];
    NSString *htmlString = @"<html>"
    "<body style='margin:0;padding:8px;background-color:red'>"
    "<div></div><div id='obj'>OBJ-DIV</div>"
    "<div id='link'><a href='http://mac.com/'>Site</a></div>"
    "<div style='text-align:center;margin:20px;'>"
    "<img id='image' style='width:50%%' src='%@'>"
    "</div>"
    "<div id='tap'>"
    "<a href='javascript:window.webkit.messageHandlers.say1.postMessage(%@)'>"
    "   Tap Here</a></div>"
    "<div><a href='http://www.apple.com'>Apple Web Site</a></div>"
    "<button onclick='window.webkit.messageHandlers.say1.postMessage(%@)'>"
    "   This is a button</button>"
    "</body></html>";
    NSString *message1 = @"1";
    NSString *message2 = @"{\"message\":\"ok\"}";
    
    NSString *source = [NSString stringWithFormat:
                        htmlString, @"photo1.jpg", message1, message2];
    [self.webView loadHTMLString: source baseURL: baseURL];
    NSLog( @"%s %@",__FUNCTION__, source);
}

-(IBAction)tapButton1:(id) sender
{
    NSString *jsString = @"document.getElementById('obj').style.backgroundColor='orange';";
    [self.webView evaluateJavaScript: jsString
                   completionHandler: ^(id returnValue, NSError *error){
                       NSLog( @"%s %@ %@",__FUNCTION__, returnValue, error);
                       
                   }];
}

-(IBAction)tapButton2:(id) sender
{
    NSString *jsString = @"document.getElementById('image').src;";
    [self.webView evaluateJavaScript: jsString
                   completionHandler: ^(id returnValue, NSError *error){
                       NSLog( @"%s %@ %@",__FUNCTION__, returnValue, error);
                       
                   }];
}

//WKNagivationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog( @"%s\n%@",__FUNCTION__, navigationAction.request.URL);
    if ([navigationAction.request.URL.host isEqualToString: @"process.inside"]){
        NSLog( @"%@", navigationAction.request.URL.query);
        NSLog( @"%@", [navigationAction.request.URL.query componentsSeparatedByString: @"&"]);
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog( @"%s",__FUNCTION__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog( @"%s",__FUNCTION__);
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog( @"%s",__FUNCTION__);
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog( @"%s %@",__FUNCTION__, error);
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog( @"%s",__FUNCTION__);
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSLog( @"%s",__FUNCTION__);
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog( @"%s %@",__FUNCTION__, navigation);
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog( @"%s %@",__FUNCTION__, navigation);
    
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler
{
    NSLog( @"%s %@",__FUNCTION__, message);
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog( @"%s",__FUNCTION__);
    completionHandler(YES);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler
{
    NSLog( @"%s",__FUNCTION__);
    
}

- (WKWebView *)webView:(WKWebView *)webView
createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration
   forNavigationAction:(WKNavigationAction *)navigationAction
        windowFeatures:(WKWindowFeatures *)windowFeatures
{
    NSLog( @"%s",__FUNCTION__);
    return webView;
}
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog( @"%s %@ %@",__FUNCTION__, message.name, message.body);
   
}
@end
