//
//  PhotoShowViewController.m
//  PhotoShow
//
//  Created by demo on 2014/06/17.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "PhotoShowViewController.h"

@interface PhotoShowViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)tapButton:(UIButton *)sender;

@end

@implementation PhotoShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)tapButton:(UIButton *)sender {
    NSString *buttonName = sender.titleLabel.text;
    
    NSLog(@"Button Name = %@", buttonName);
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource: buttonName
                                                          ofType: @"jpg"];
    UIImage *photoImage = [UIImage imageWithContentsOfFile: imagePath];
    self.imageView.image = photoImage;
 
//    CGRect initialRect = self.imageView.frame;
//    self.imageView.frame = CGRectZero;
//    [UIView animateWithDuration: 2.0
//                     animations: ^(){
//                         self.imageView.frame = initialRect;
//                     }];
}
@end
