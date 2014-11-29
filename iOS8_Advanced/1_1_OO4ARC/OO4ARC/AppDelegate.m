//
//  AppDelegate.m
//  1_1_OO4ARC
//
//  Created by Masayuki Nii on 2013/12/11.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "AppDelegate.h"
#import "TestClass.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    __weak NSString *x = [[NSString alloc]initWithFormat: @"total"];
    NSLog(@"%@", x);
    
    NSString *y =[[NSString alloc]initWithFormat: @"total"];
    NSLog(@"retaincount=%ld",
          CFGetRetainCount((__bridge CFTypeRef)(y)));
    
    TestClass *obj1 = [[TestClass alloc] init];
    TestClass *obj2 = [[TestClass alloc] init];
    TestClass *obj3 = [[TestClass alloc] init];
    __weak id objw1 = obj1;
    __weak id objw2 = obj2;
    __weak id objw3 = obj3;
    NSLog(@"obj1=%ld, obj2=%ld, obj3=%ld",
          CFGetRetainCount((__bridge CFTypeRef)(objw1)),
          CFGetRetainCount((__bridge CFTypeRef)(objw2)),
          CFGetRetainCount((__bridge CFTypeRef)(objw3)));
    obj1.nextObject = obj2;
    obj2.nextObject = obj3;
    obj3.nextObject = obj1;
    NSLog(@"obj1=%ld, obj2=%ld, obj3=%ld",
          CFGetRetainCount((__bridge CFTypeRef)(objw1)),
          CFGetRetainCount((__bridge CFTypeRef)(objw2)),
          CFGetRetainCount((__bridge CFTypeRef)(objw3)));
    obj1 = nil;
    NSLog(@"obj1=%ld, obj2=%ld, obj3=%ld",
          CFGetRetainCount((__bridge CFTypeRef)(objw1)),
          CFGetRetainCount((__bridge CFTypeRef)(objw2)),
          CFGetRetainCount((__bridge CFTypeRef)(objw3)));

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
