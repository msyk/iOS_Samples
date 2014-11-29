//
//  ViewController.m
//  ViewTest_ObjC
//
//  Created by 新居雅行 on 2014/10/01.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIContentContainer>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __FUNCTION__);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%s", __FUNCTION__);
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)viewDidLayoutSubviews
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)viewWillLayoutSubviews
{
    NSLog(@"%s", __FUNCTION__);

}

// Try to comment out the method below
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)updateViewConstraints
{
    NSLog(@"%s", __FUNCTION__);
    [super updateViewConstraints];
}

- (void)awakeFromNib    {
    NSLog(@"%s", __FUNCTION__);

}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%s", __FUNCTION__);

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"%s", __FUNCTION__);
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"%s", __FUNCTION__);
    
}

@end
