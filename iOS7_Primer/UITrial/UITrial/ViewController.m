//
//  ViewController.m
//  UITrial
//
//  Created by demo on 2014/06/17.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)tapButton:(id)sender;
- (IBAction)moveSlider:(id)sender;

@end

@implementation ViewController

- (IBAction)tapButton:(id)sender
{
    if ( self.imageView.alpha < 0.5 )    {
        self.imageView.alpha = 0.0;
    } else {
        self.imageView.alpha = 1.0;
    }
}

- (IBAction)moveSlider: (id)sender
{
    UISlider *slider = sender;
    self.imageView.alpha = slider.value;
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

@end
