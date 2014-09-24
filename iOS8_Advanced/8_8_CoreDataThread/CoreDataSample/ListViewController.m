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

#ifdef SESSION1
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
    
    cell.textLabel.text = myself.name;
    cell.detailTextLabel.text = myCompany.company;
    
    return cell;
}
#endif
#ifdef SESSION2
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.localDB.selectedData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Company *company = self.localDB.selectedData[section];
    return company.people.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"
                                                            forIndexPath: indexPath];
    Company *myCompany = self.localDB.selectedData[indexPath.section];
    People *myself = [myCompany.people objectAtIndex: indexPath.row];
    
    cell.textLabel.text = myself.name;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat: @"yyyy/MM/dd"];
    cell.detailTextLabel.text = [fmt stringFromDate: myself.birthday];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Company *company = self.localDB.selectedData[section];
    return company.company;
}
#endif

@end
