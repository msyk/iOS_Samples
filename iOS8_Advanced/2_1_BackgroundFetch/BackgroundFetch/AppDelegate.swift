//
//  AppDelegate.swift
//  BackgroundFetch
//
//  Created by 新居雅行 on 2014/09/09.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        println("didFinishLaunchingWithOptions on \(NSDate())")
        
        application.setMinimumBackgroundFetchInterval(
            UIApplicationBackgroundFetchIntervalMinimum)
        
        NSTimer.scheduledTimerWithTimeInterval(
            0.5, target: self, selector: "myTask:", userInfo: nil, repeats: false);
        
        
        
        return true
    }
    
    func myTask (theTimer: NSTimer) -> ()	{
        let application = UIApplication.sharedApplication();
        for i in 1...2000	{
            println("\(i)#Now = \(NSDate()) \(application.backgroundTimeRemaining)")
            for x in 1...10000 {
                var y = atan(Double(x))
            }
            NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 1.0))
        }
    }
    
    func application(application: UIApplication,
        performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void ) {
            println("performFetchWithCompletionHandler on \(NSDate())")
            
            //            let notifying = UILocalNotification()
            //            notifying.fireDate = NSDate(timeIntervalSinceNow: 10.0)
            //            notifying.timeZone = NSTimeZone.defaultTimeZone()
            //            notifying.alertBody = "Test"
            //            notifying.hasAction = true
            //            notifying.alertAction = "OK"
            //            application.scheduleLocalNotification(notifying)
            //            application.presentLocalNotificationNow(notifying)
            let url = NSURL.URLWithString("http://msyk.net")
            let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
            let session = NSURLSession(configuration: config)
            let task = session.dataTaskWithURL(url,
                completionHandler: {
                    (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void
                    in
                    println("dataTaskWithURL-completionHandler[\(data.length)]")
                    session.finishTasksAndInvalidate()
//                    for x in 1...1000000 {
//                        var y = atan(Double(x))
//                        NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 1.0))
//                    }
//                    println("dataTaskWithURL-completionHandler[\(data.length)]")
                    completionHandler(.NoData)
            })
            task.resume()
    }
    
    func application(application: UIApplication,
        didReceiveLocalNotification notification: UILocalNotification) {
            println("didReceiveLocalNotification")
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String,
        annotation: AnyObject?) -> Bool  {
            println("openURL \(url)")
            println("sourceApplication \(sourceApplication)")
            println("annotation \(annotation)")
            
            return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

