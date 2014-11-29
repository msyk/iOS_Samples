//
//  DataViewController.m
//  PageView
//
//  Created by 新居雅行 on 2014/10/29.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    NSLog( @"%s", __FUNCTION__ );
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog( @"%s", __FUNCTION__ );
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];

    NSString *fileName = [self.dataObject description];
    NSString *imagePath
    = [[NSBundle mainBundle] pathForResource: fileName
                                      ofType: @"jpg"];
    self.photoView.image
    = [UIImage imageWithContentsOfFile: imagePath];
    self.photoView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
