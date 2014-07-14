//
//  ViewController.m
//  4_3_WebView
//
//  Created by Masayuki Nii on 2014/01/18.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, weak) IBOutlet UIWebView *webView;

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
    
    NSURL *baseURL = [[NSBundle mainBundle] resourceURL];
    NSString *htmlString = @"<html>"
    "<body style='margin:0;padding:8px;background-color:red'>"
    "<div></div><div id='obj'>OBJ-DIV</div>"
    "<div id='link'><a href='http://mac.com/'>Site</a></div>"
    "<div style='text-align:center;margin:20px;'>"
    "<img id='image' style='width:50%%' src='%@'>"
    "</div>"
    "<div id='tap'><a href='taplink://?id=100&p=200'>Tap Here</a></div>"
    "</body></html>";
    
    NSString *source = [NSString stringWithFormat: htmlString, @"photo1.jpg"];
    [self.webView loadHTMLString: source baseURL: baseURL];
    NSLog( @"%s %@",__FUNCTION__, source);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog( @"%s",__FUNCTION__);
}

-(BOOL)            webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
            navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog( @"%s",__FUNCTION__);
    NSLog( @"request = %@", request);
    NSLog( @"navigationType = %d", navigationType);
    return YES;
}

-(IBAction)tapButton1:(id) sender
{
    NSString *jsString = @"document.getElementById('obj').style.backgroundColor='orange';";
    [self.webView stringByEvaluatingJavaScriptFromString: jsString];
}

-(IBAction)tapButton2:(id) sender
{
    NSString *jsString = @"document.getElementById('image').src;";
    NSString *returnString = [self.webView stringByEvaluatingJavaScriptFromString: jsString];
    NSLog(@"returnString = %@", returnString);
}


@end
