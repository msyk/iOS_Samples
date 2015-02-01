//
//  AppDelegate.swift
//  Collections_Swift
//
//  Created by 新居雅行 on 2015/01/31.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
            // Override point for customization after application launch.
            
            let ar = ["a", "b", "c", "d"]
            println("result01 = \(ar)")
            println("result02 = \(ar[2])")
            //    println("result03 = \(ar[100])")
            //        ar[0] = "w"
            
            let dic = ["k1":"a", "k2":"b", "k3":"c", "k4":"d"]
            println("result04 = \(dic)")
            println("result05 = " + dic["k1"]!)
            if let value = dic["k100"] {
                println("result06 = \(value)")
            }
            var mar = ["a", "b", "c", "d"]
            println("result07 = \(mar)")
            println("result08 = \(mar[2])")
            mar[2] = "xxxxx"
            println("result09 = \(mar)")
            mar[1...2] = ["rep1", "rep2"]
            println("result09-2 = \(mar)")
            if mar.endIndex > 30 {
                mar[30] = "thirty"
            }
            println("result10 = \(mar)")
            
            mar += ["add1"]
            println("result11 = \(mar)")
            mar.append("add0")
            println("result11-2 = \(mar)")
            
            mar.insert("add2", atIndex: 2)
            println("result12 = \(mar)")
            
            mar.removeAtIndex(1)
            println("result13 = \(mar)")
            
            println("result14 = \(mar.count)")
            let s1 = find(mar, "rep2")
            println("result15 = \(s1)")
            let s2 = find(mar, "xx")
            println("result16 = \(s2)")
            
            var mdic = ["k1":"a", "k2":"b", "k3":"c", "k4":"d"]
            
            println("result17 = \(mdic)")
            println("result18 = " + mdic["k1"]!)
            mdic["k1"] = "yyyyyy";
            println("result19 = \(mdic)")
            if let value = dic["k100"] {
                println("result20 = " + value)
            }
            mdic["k100"] = "handred";
            println("result21 = \(mdic)")
            mdic.removeValueForKey("k4")
            println("result22 = \(mdic)")
            println("result23 = \(mdic.count)")
            
            
var addressBook = [
    ["名前":"鈴木一郎", "読み":"すずき","年齢":"34", "住所":"東京都"],
    ["名前":"佐藤二朗", "読み":"さとう","年齢":"21", "住所":"神奈川県"],
    ["名前":"高橋三郎", "読み":"たかはし","年齢":"55", "住所":"埼玉県"],
    ["名前":"田中四郎", "読み":"たなか","年齢":"9", "住所":"千葉県"],
    ["名前":"伊藤五郎", "読み":"いとう","年齢":"78", "住所":"山梨県"],]
println("result26 = \(addressBook)")
println("result27 = \(addressBook[0])")

for person in addressBook {
    if let name = person["名前"] {
        println("result28 = " + name);
    }
}
for person in addressBook {
    for (key, value) in person {
        println("result30 = \(key):\(value)")
    }
}
sort(&addressBook){
    (dict1: Dictionary, dict2: Dictionary) -> Bool in
    return dict1["読み"] < dict2["読み"]
}
println("result31 = \(addressBook)")
sort(&mar){
    (s1: String, s2: String) -> Bool in
    return s1 < s2
}
println("result32 = \(mar)")
            
            
            //======
            var index = -1
            var counter = 0
            for person in addressBook {
                if person["名前"] == "高橋三郎" {
                    index = counter
                    break
                }
                counter++
            }
            println("result 4-A = \(index)")

            sort(&addressBook){
                (dict1: Dictionary, dict2: Dictionary) -> Bool in
                return dict1["年齢"]?.toInt() < dict2["年齢"]?.toInt()
            }
            println("result 4-B = \(addressBook)")

            var result: [String] = []
            for person in addressBook {
                if person["年齢"]?.toInt() >= 50 {
                    result.append(person["名前"]!)
                }
            }
            println("result 4-C = \(result)")

            var adic: [String : Int] = ["a":1,"b":2]
            var aar: [String] = ["a",]
            
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

