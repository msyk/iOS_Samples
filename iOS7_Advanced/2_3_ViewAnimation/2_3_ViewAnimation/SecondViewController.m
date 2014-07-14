//
//  SecondViewController.m
//  2_3_ViewAnimation
//
//  Created by Masayuki Nii on 2013/12/26.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIView *boxView;
- (IBAction)tapAnotherView:(id)sender;
- (IBAction)tapAnimating:(id)sender;
@end

@implementation SecondViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapAnotherView:(id)sender {
    NSLog( @"self.view=%@", self.view);
    UIView *newView = [[UIView alloc]initWithFrame: self.view.frame];
    newView.backgroundColor = [UIColor yellowColor];
    [UIView transitionFromView: self.view
                        toView: newView
                      duration: 3.0
                       options: UIViewAnimationOptionTransitionFlipFromLeft
                    completion: ^(BOOL finished){
                        NSLog( @"self.view=%@", self.view);
                    }];
}

- (IBAction)tapAnimating:(id)sender {
    CGPoint center = self.boxView.center;
    CGPoint point1 = CGPointMake(center.x + 100.0, center.y);
    CGPoint point2 = CGPointMake(center.x + 100.0, center.y + 100.0);
    CGPoint point3 = CGPointMake(center.x - 100.0, center.y + 100.0);
    [UIView animateWithDuration: 2.0
                     animations: ^(){
                         self.boxView.center = point1;
                     }
                     completion: ^(BOOL finished){
                         [UIView animateWithDuration: 2.0
                                          animations: ^(){
                                              self.boxView.center = point2;
                                          }
                                          completion: ^(BOOL finished){
                                              self.boxView.center = point3;
                                          }];
                     }];
}
@end
