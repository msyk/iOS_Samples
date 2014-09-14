//
//  AppDelegate.m
//  PlaceMap
//
//  Created by demo on 2014/09/14.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "AppDelegate.h"
#import "PlaceDatabase.h"
#import "MapDisplayViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@property (strong, nonatomic) UIPopoverController *masterPOC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.placeDB = [[PlaceDatabase alloc] init];
    
        UISplitViewController *splitVC = (UISplitViewController *)self.window.rootViewController;
        splitVC.delegate = self;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Split view

- (BOOL)     splitViewController: (UISplitViewController *)splitViewController
 collapseSecondaryViewController: (UIViewController *)secondaryViewController
       ontoPrimaryViewController: (UIViewController *)primaryViewController {
    
     if([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return NO;
    }
}

- (void)splitViewController: (UISplitViewController *)svc
     willShowViewController: (UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)button
{
    NSLog(@"%s", __FUNCTION__);
    
    UISplitViewController *splitVC = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *detailNC = (UINavigationController *)splitVC.viewControllers[1];
    NSArray *barItems = detailNC.navigationBar.items;
    ((UINavigationItem *)barItems[0]).leftBarButtonItem = nil;
    self.masterPOC = nil;
}

- (void)splitViewController: (UISplitViewController *)svc
     willHideViewController: (UIViewController *)aViewController
          withBarButtonItem: (UIBarButtonItem *)barButtonItem
       forPopoverController: (UIPopoverController *)pc
{
    NSLog(@"%s", __FUNCTION__);
    
    UISplitViewController *splitVC = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *detailNC = (UINavigationController *)splitVC.viewControllers[1];
    barButtonItem.title = @"Prefectural Capital";
    NSArray *barItems = detailNC.navigationBar.items;
    ((UINavigationItem *)barItems[0]).leftBarButtonItem = barButtonItem;
    self.masterPOC = pc;
}


@end
