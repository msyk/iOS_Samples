//
//  ViewController.m
//  WebView
//
//  Created by 新居雅行 on 2014/10/29.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, weak) IBOutlet UIWebView *webView;

-(IBAction)tapButton1:(id) sender;
-(IBAction)tapButton2:(id) sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *baseURL = [[NSBundle mainBundle] resourceURL];
    NSString *htmlString = @"<html>"
    "<body style='margin:0;padding:0;background-color:red'>"
    "<div id='obj'>OBJ-DIV</div>"
    "<div id='link'><a href='http://mac.com/'>Site</a></div>"
    "<img id='image' src='photo1.jpg'>"
    "<div id='tap'><a href='taplink://?id=100&p=200'>Tap Here</a></div>"
    "</body></html>";
    
    [self.webView loadHTMLString: htmlString baseURL: baseURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog( @"%s",__FUNCTION__);
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog( @"%s",__FUNCTION__);
    NSLog( @"request = %@", request);
    NSLog( @"navigationType = %d", navigationType);
    return YES;
}

-(IBAction)tapButton1:(id) sender
{
    NSString *jsString
    = @"document.getElementById('obj').style.backgroundColor='orange';";
    [self.webView stringByEvaluatingJavaScriptFromString: jsString];
}
-(IBAction)tapButton2:(id) sender
{
    NSString *jsString
    = @"document.getElementById('image').src;";
    NSString *returnString
    = [self.webView stringByEvaluatingJavaScriptFromString: jsString];
    NSLog(@"returnString = %@", returnString);
}
@end
