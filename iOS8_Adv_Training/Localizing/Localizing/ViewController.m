//
//  ViewController.m
//  Localizing
//
//  Created by 新居雅行 on 2014/10/28.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UITextView *message;
- (IBAction)tapButton:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapButton:(id)sender {
    NSString *seedString = NSLocalizedString(@"message1", nil);;
    NSString *msgString = [NSString stringWithFormat: seedString, self.input.text];
    self.message.text = msgString;
}
@end
