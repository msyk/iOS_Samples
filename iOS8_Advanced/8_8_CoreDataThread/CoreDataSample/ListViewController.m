//
//  ViewController.m
//  6_CoreDataSample
//
//  Created by Masayuki Nii on 2014/02/02.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ListViewController.h"
#import "LocalDB.h"
#import "People.h"
#import "Company.h"

@interface ListViewController ()
@property(nonatomic, strong) LocalDB *localDB;
@end

@implementation ListViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.localDB = [[LocalDB alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.localDB.selectedData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"
                                                            forIndexPath: indexPath];
    People *myself = self.localDB.selectedData[indexPath.row];
    Company *myCompany = myself.company;
    
    NSString *x = myself.name;
    cell.textLabel.text = myself.name;
    cell.detailTextLabel.text = myCompany.company;
    
    return cell;
}

@end
