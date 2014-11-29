//
//  ViewController.h
//  4_3_WebView
//
//  Created by Masayuki Nii on 2014/01/18.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController <WKNavigationDelegate, WKScriptMessageHandler, WKUIDelegate>

@end
