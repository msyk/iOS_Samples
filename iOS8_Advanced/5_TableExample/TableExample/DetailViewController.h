//
//  DetailViewController.h
//  TableExample
//
//  Created by 新居雅行 on 2014/09/22.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

