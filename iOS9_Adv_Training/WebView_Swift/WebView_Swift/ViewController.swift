//
//  ViewController.swift
//  WebView_Swift
//
//  Created by 新居雅行 on 2015/01/30.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet private weak var webView: UIWebView?
    
    @IBAction private func tapButton1(sender: UIButton) {
        let js = "document.getElementById('obj').style.backgroundColor='orange';"
        webView?.stringByEvaluatingJavaScriptFromString(js)
    }
    
    @IBAction private func tapButton2(sender: UIButton) {
        let js = "document.getElementById('image').src;"
        let returnString = webView?
            .stringByEvaluatingJavaScriptFromString(js)
        print("returnString = \(returnString)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseURL = NSBundle.mainBundle().resourceURL;
        let htmlString = "<html>"
            + "<body style='margin:0;padding:0;background-color:red'>"
            + "<div id='obj'>OBJ-DIV</div>"
            + "<div id='link'><a href='http://mac.com/'>Site</a></div>"
            + "<img id='image' src='photo1.jpg'>"
            + "<div id='tap'><a href='taplink://?id=100&p=200'>Tap Here</a></div>"
            + "</body></html>"
        
        webView?.loadHTMLString(htmlString, baseURL: baseURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print(__FUNCTION__)
    }
    
    func webView(webView: UIWebView,
        shouldStartLoadWithRequest request: NSURLRequest,
        navigationType: UIWebViewNavigationType) -> Bool {
            print(__FUNCTION__)
            print("request = \(request)")
            print("navigationTyle = \(navigationType)")
            return true
    }
    
}

