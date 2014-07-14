//
//  AppDelegate.h
//  PhotoShow
//
//  Created by demo on 2014/06/17.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoShowViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) IBOutlet PhotoShowViewController *photoShow;


@end
