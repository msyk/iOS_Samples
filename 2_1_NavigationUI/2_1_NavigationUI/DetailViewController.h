//
//  DetailViewController.h
//  2_1_NavigationUI
//
//  Created by Masayuki Nii on 2013/12/21.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
