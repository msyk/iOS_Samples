//
//  DetailViewController.h
//  TableExample
//
//  Created by 新居雅行 on 2014/09/22.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MasterViewController;

@interface DetailViewController : UITableViewController
    <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) MasterViewController *masterViewController;
@property (nonatomic) NSInteger detailIndex;

- (void)updateContent;

@end

