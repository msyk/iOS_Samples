//
//  MasterViewController.h
//  MasterDetail
//
//  Created by 新居雅行 on 2014/09/21.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

