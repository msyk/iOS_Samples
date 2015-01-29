//
//  ModelController.h
//  PageView_ObjC
//
//  Created by 新居雅行 on 2015/01/29.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

