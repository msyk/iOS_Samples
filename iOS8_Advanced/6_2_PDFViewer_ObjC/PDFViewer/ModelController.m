//
//  ModelController.m
//  4_1_PDFViewer
//
//  Created by Masayuki Nii on 2014/01/13.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface ModelController()

@end

@implementation ModelController

- (id)init
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    self = [super init];
    if (self) {
        [self initializePageData: nil];
    }
    return self;
}

- (void)initializePageData: (NSURL *)url
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    self.documentRef = NULL;
    self.totalPage = 0;
    if (url != nil) {
        self.documentRef = CGPDFDocumentCreateWithURL((__bridge CFURLRef)url);
        self.totalPage = CGPDFDocumentGetNumberOfPages(self.documentRef);
    }
}

- (DataViewController *)viewControllerAtIndex: (NSUInteger)index
                                   storyboard: (UIStoryboard *)storyboard
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    // Return the data view controller for the given index.
    if ((self.totalPage > 0) && (index >= self.totalPage)) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController
    = [storyboard instantiateViewControllerWithIdentifier: @"DataViewController"];
    dataViewController.page = index + 1;
    if (index + 1 > CGPDFDocumentGetNumberOfPages(self.documentRef))    {
        dataViewController.pageRef = nil;
    } else {
        dataViewController.pageRef = CGPDFDocumentGetPage( self.documentRef, index + 1 );
    }
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return viewController.page - 1;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController: (UIPageViewController *)pageViewController
      viewControllerBeforeViewController: (UIViewController *)viewController
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    NSUInteger index = [self indexOfViewController: (DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex: index
                            storyboard: viewController.storyboard];
}

- (UIViewController *)pageViewController: (UIPageViewController *)pageViewController
       viewControllerAfterViewController: (UIViewController *)viewController
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    NSUInteger index = [self indexOfViewController: (DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == self.totalPage) {
        return nil;
    }
    return [self viewControllerAtIndex: index
                            storyboard: viewController.storyboard];
}

@end
