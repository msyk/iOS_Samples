//
//  FirstViewController.m
//  2_3_ViewAnimation
//
//  Created by Masayuki Nii on 2013/12/26.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
- (IBAction)tapShowPhoto:(id)sender;
- (IBAction)tapHidePhoto:(id)sender;

@end

@implementation FirstViewController

- (id)init
{
    NSLog( @"%s", __FUNCTION__);
    self = [super init];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSLog( @"%s", __FUNCTION__);
    self = [super initWithCoder: aDecoder];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog( @"%s", __FUNCTION__);
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog( @"%s", __FUNCTION__);
    [super viewDidAppear: animated];
//    [self.photoView needsUpdateConstraints];
//    [self.photoView updateConstraints];
//    [self updateViewConstraints];
}
- (void)updateViewConstraints
{
    NSLog( @"%s", __FUNCTION__);
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapShowPhoto:(id)sender {
    [UIView animateWithDuration: 2.0 animations: ^(){
        self.photoView.alpha = 1.0;
        self.view.backgroundColor = [UIColor greenColor];
    }];
}

- (IBAction)tapHidePhoto:(id)sender {
    [UIView animateWithDuration: 2.0 animations: ^(){
        self.photoView.alpha = 0.0;
        self.view.backgroundColor = [UIColor yellowColor];
    }];
}
@end
