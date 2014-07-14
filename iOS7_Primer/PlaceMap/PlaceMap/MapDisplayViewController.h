//
//  MapDisplayViewController.h
//  PlaceMap
//
//  Created by demo on 2014/06/26.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapDisplayViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic) NSInteger selectedIndex;

- (void)updateContent;

@end
