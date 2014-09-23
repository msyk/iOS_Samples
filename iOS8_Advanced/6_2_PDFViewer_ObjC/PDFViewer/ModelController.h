//
//  ModelController.h
//  4_1_PDFViewer
//
//  Created by Masayuki Nii on 2014/01/13.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

@property (assign, nonatomic) NSInteger totalPage;
@property (strong, nonatomic) __attribute__((NSObject)) CGPDFDocumentRef documentRef;

- (DataViewController *)viewControllerAtIndex: (NSUInteger)index
                                   storyboard: (UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController: (DataViewController *)viewController;
- (void)initializePageData: (NSURL *)url;

@end
