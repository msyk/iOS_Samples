//
//  SubViewController.m
//  2_5_OtherUIs
//
//  Created by Masayuki Nii on 2013/12/29.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

- (IBAction)tapCloseButton:(id)sender;

@end

@implementation SubViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.doAfterDisappear = nil;
        self.myPopover = nil;
        self.isModalDialog = NO;
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    
    [self.doAfterDisappear main];
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

- (IBAction)tapCloseButton:(id)sender {
    if (self.myPopover != nil)   {
        [self.myPopover dismissPopoverAnimated: YES];
    }
    else if (self.isModalDialog)    {
        [self dismissViewControllerAnimated: YES completion: ^(){}];
    }
}

@end
