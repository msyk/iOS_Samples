//
//  ViewController.m
//  1_3_ParseData
//
//  Created by Masayuki Nii on 2013/12/15.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "ViewController.h"
#import "ParseData-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    GenerateXML *xmlGenerator = [[GenerateXML alloc] init];
    [xmlGenerator testGenerateXML];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
