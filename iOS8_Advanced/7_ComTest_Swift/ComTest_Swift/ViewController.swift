//
//  ViewController.swift
//  ComTest_Swift
//
//  Created by 新居雅行 on 2014/11/16.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //    required init(coder aDecoder: NSCoder) {
    //        resultString = nil
    //        queue = NSOperationQueue()
    //        super.init()
    //    }
    //
    //    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    //        resultString = nil
    //        queue = NSOperationQueue()
    //        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var resultString: String?
    var queue: NSOperationQueue?
    //@property (strong, nonatomic) ComTestMod *ct;
    @IBOutlet weak var resultText: UITextView?
    
    
    @IBAction func tapButton1(sender: AnyObject) {
        debugLogging("Start!")
        resultString = "- didn't set it -";
        resultText?.text = "";
        
        let finishTask = NSBlockOperation(block:{
            debugLogging()
            self.resultText?.text = self.resultString;
        })
        
        let url = NSURL(string: "http://zip2.cgis.biz/xml/zip.php?zn=1010021")
        //        let url = NSURL(string: "http://abc.def.com")
        //        let url = NSURL(string: "http://10.0.1.249")
        //        let url = NSURL(string: "http://zip2.cgis.biz/xxxxx")
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration();
        
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithURL(url!,
            completionHandler:{
                (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                
                debugLogging()
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                self.resultString = dataString as String?
                debugLogging("[Data]\(self.resultString)")
                if (response != nil)    {
                    debugLogging("[Response]\(response!.description)")
                }
                if (error != nil) {
                    debugLogging("[Error]\(error!.description)")
                }
                let mainQueue = NSOperationQueue.mainQueue()
                mainQueue.addOperation(finishTask)
                session.finishTasksAndInvalidate()
        })
        task.resume()
        debugLogging("End!")
    }
    
    @IBAction func tapButton2(sender: AnyObject) {
    }
    
    @IBAction func tapButton3(sender: AnyObject) {
    }
    
    @IBAction func tapButton34(sender: AnyObject) {
    }
    
    @IBAction func tapButton5(sender: AnyObject) {
    }
    
    @IBAction func tapButton6(sender: AnyObject) {
    }
    
    @IBAction func tapButton7(sender: AnyObject) {
    }
    
    @IBAction func tapButton8(sender: AnyObject) {
    }
    
}

