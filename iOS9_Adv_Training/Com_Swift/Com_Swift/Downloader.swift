//
//  Downloader.swift
//  Com_Swift
//
//  Created by 新居雅行 on 2015/01/30.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

class Downloader: NSObject {
    
    var parsedData = [[:]]
    
    convenience init(url: NSURL?, afterTask doItAfter: ()->Void)   {
        self.init()
        
        if let accessURL = url {
            let config = NSURLSessionConfiguration
                .ephemeralSessionConfiguration()
            let session = NSURLSession(configuration: config)
            let task = session.dataTaskWithURL(accessURL,
                completionHandler: {
                    (data: NSData?,
                    response: NSURLResponse?,
                    error: NSError?) -> Void in
                    //                    let received = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    //                    var jsonError: NSError?
                    guard let _ = data else {
                        print("error = \(error)")
                        return
                    }
                    do {
                        let parsed = try NSJSONSerialization.JSONObjectWithData(data!,
                            options: NSJSONReadingOptions.AllowFragments)
                        self.parsedData = parsed as! Array
                        print("downloaded = \(self.parsedData)")
                        NSOperationQueue.mainQueue().addOperationWithBlock(doItAfter)
//                        doItAfter()
                    } catch _ {
                        print("JSON parse error")
                    }
                    session.finishTasksAndInvalidate()
            })
            task.resume()
        }
    }
    convenience init(url: NSURL?)   {
        self.init()
        
        if let accessURL = url {
            let config = NSURLSessionConfiguration
                .defaultSessionConfiguration()
            let session = NSURLSession(configuration: config,
                delegate: nil, delegateQueue: nil)
            let task = session.dataTaskWithURL(accessURL,
                completionHandler: {
                    (data: NSData?,
                    response: NSURLResponse?,
                    error: NSError?) -> Void in
                    guard let _ = data else {
                        print("error = \(error)")
                        return
                    }
                    let received = NSString(data: data!,
                        encoding: NSUTF8StringEncoding)
                    print("received data = \(received)")
                    session.finishTasksAndInvalidate()
            })
            task.resume()
        }
    }
}
