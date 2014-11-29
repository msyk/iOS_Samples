//
//  RootViewController.m
//  SplitViewIPhone
//
//  Created by 新居雅行 on 2014/10/28.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UISplitViewControllerDelegate>

@property (strong,nonatomic) UIViewController *containingVC;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *storyboard = self.storyboard;
    UISplitViewController *svc
        = [storyboard
           instantiateViewControllerWithIdentifier: @"SPLITVIEW"];
    self.containingVC = svc;
    [self addChildViewController: svc];
    [svc didMoveToParentViewController: self];
    [self.view addSubview: svc.view];
}

- (void)viewWillTransitionToSize: (CGSize)size
       withTransitionCoordinator:
           (id<UIViewControllerTransitionCoordinator>)coordinator
{
    if ([UIDevice currentDevice].userInterfaceIdiom
        == UIUserInterfaceIdiomPhone) {
        if (size.width > size.height)  {
            UITraitCollection *tc
                = [UITraitCollection
                   traitCollectionWithHorizontalSizeClass:
                       UIUserInterfaceSizeClassRegular];
            [self setOverrideTraitCollection: tc
                      forChildViewController: self.containingVC];
        } else {
            [self setOverrideTraitCollection: nil
                      forChildViewController: self.containingVC];
        }
        [self.containingVC didMoveToParentViewController: self];
    }
}

- (BOOL)    splitViewController:
              (UISplitViewController *)splitViewController
collapseSecondaryViewController:
              (UIViewController *)secondaryViewController
      ontoPrimaryViewController:
              (UIViewController *)primaryViewController
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
