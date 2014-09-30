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
    
    self.localDB = [[LocalDB alloc]initWithCompletion: ^(){
        [self.localDB selectedPeople: nil
                             orderBy: nil
                          completion: ^(NSArray *result, NSError *error){
                              NSLog(@"%s %d", __FUNCTION__, [NSThread isMainThread]);

                              [self.localDB setSelectedData: result];
                              [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                                  [self.tableView reloadData];
                              }];
                          }];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
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
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    return [self.localDB countSelectedData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"
                                                            forIndexPath: indexPath];
    NSDictionary *myself = [self.localDB selectedDataOfIndex: indexPath.row];
    
    cell.textLabel.text = myself[@"name"];
    cell.detailTextLabel.text = myself[@"company"][@"company"];
    
    return cell;
}

@end
