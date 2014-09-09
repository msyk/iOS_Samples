//
//  DetailViewController.h
//  3_TableExample
//
//  Created by Masayuki Nii on 2014/01/05.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MasterViewController;

@interface DetailViewController : UITableViewController
    <UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) MasterViewController *masterViewController;
@property (nonatomic) NSInteger detailIndex;

- (void)updateContent;

@end
