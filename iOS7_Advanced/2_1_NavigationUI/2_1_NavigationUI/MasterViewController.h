//
//  MasterViewController.h
//  2_1_NavigationUI
//
//  Created by Masayuki Nii on 2013/12/21.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
