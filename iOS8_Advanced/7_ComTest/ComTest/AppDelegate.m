//
//  AppDelegate.m
//  5_ComTest
//
//  Created by Masayuki Nii on 2014/01/21.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)                 application: (UIApplication *)application
 handleEventsForBackgroundURLSession: (NSString *)identifier
                   completionHandler: (void (^)())completionHandler
{
#ifdef DEBUG
    NSLog( @"%s %@", __FUNCTION__, identifier );
#endif
    UILocalNotification *notify = [[UILocalNotification alloc] init];
    notify.alertAction = nil;
    notify.alertBody = @"Your download task has finished.";
    notify.hasAction = YES;
//    notify.alertLaunchImage = @"aFile";
    notify.applicationIconBadgeNumber = 99;
    [[UIApplication sharedApplication] presentLocalNotificationNow: notify];
    
//    completionHandler();
    
    self.downloadCompletionHandler = completionHandler;
}

- (void)         application: (UIApplication *)application
 didReceiveLocalNotification: (UILocalNotification *)notification
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (BOOL)           application: (UIApplication *)application
 didFinishLaunchingWithOptions: (NSDictionary *)launchOptions
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    UIUserNotificationType types = UIUserNotificationTypeAlert
                                 | UIUserNotificationTypeBadge
                                 | UIUserNotificationTypeSound;
    UIUserNotificationSettings *settings
        = [UIUserNotificationSettings settingsForTypes: types
                                            categories: nil];
    [application registerUserNotificationSettings: settings];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return YES;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return UIInterfaceOrientationMaskAll;
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return nil;
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)applicationSignificantTimeChange:(UIApplication *)application
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)applicationWillResignActive:(UIApplication *)application
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)applicationWillTerminate:(UIApplication *)application
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}


@end
