//
//  MasterViewController.m
//  TableExample
//
//  Created by 新居雅行 on 2014/09/22.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#define CUSTOM_CELL

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "PersonData.h"
#import "MyCustomCellTableViewCell.h"

@interface MasterViewController ()

@property (nonatomic, strong) NSString *fieldNameName;
@property (nonatomic, strong) NSString *fieldNamePhone;
@property (nonatomic, strong) NSString *fieldNameBirthday;

- (IBAction)tapInsertButton: (id)sender;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [super viewDidLoad];
    
    PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
    self.fieldNameName = pd.fieldNames[0];
    self.fieldNamePhone = pd.fieldNames[1];
    self.fieldNameBirthday = pd.fieldNames[2];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    UINavigationController *detailArea = [self.splitViewController.viewControllers lastObject];
//    self.detailViewController = (DetailViewController *)[detailArea topViewController];
//    self.detailViewController.masterViewController = self;
}

- (void)didReceiveMemoryWarning
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapInsertButton: (id)sender
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
    [pd insert];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: 0 inSection: 0];
    [self.tableView insertRowsAtIndexPaths: @[indexPath]
                          withRowAnimation: UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (CGFloat)    tableView: (UITableView *)tableView
 heightForRowAtIndexPath: (NSIndexPath *)indexPath
{
    return 44.0;
}

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    return 1;
}

- (NSInteger)tableView: (UITableView *)tableView
 numberOfRowsInSection: (NSInteger)section
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
    return pd.people.count;
}

#ifdef CUSTOM_CELL

- (UITableViewCell *)tableView: (UITableView *)tableView
         cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s %@", __FUNCTION__, indexPath);
#endif
    PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
    MyCustomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CellCustom"
                                                                      forIndexPath: indexPath];
    cell.nameField.text = pd.people[indexPath.row][self.fieldNameName];
    cell.phoneField.text = pd.people[indexPath.row][self.fieldNamePhone];
    cell.birthdayField.text = pd.people[indexPath.row][self.fieldNameBirthday];
    return cell;
}

#else

- (UITableViewCell *)tableView: (UITableView *)tableView
         cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s %@", __FUNCTION__, indexPath);
#endif
    PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CellBasic"
    //                                                            forIndexPath: indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CellRightDetail"
                                                            forIndexPath: indexPath];
    cell.textLabel.text = pd.people[indexPath.row][self.fieldNameName];
    cell.detailTextLabel.text = pd.people[indexPath.row][self.fieldNamePhone];
    return cell;
}

#endif

- (void)prepareForSegue: (UIStoryboardSegue *)segue
                 sender: (id)sender
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        UITableViewCell *tappedCell = sender;
        UINavigationController *detailNC = [segue destinationViewController];
        DetailViewController *detailVC = (DetailViewController *)detailNC.topViewController;
        detailVC.detailIndex = [self.tableView indexPathForCell: tappedCell].row;
        detailVC.masterViewController = self;
    }
}

- (BOOL)     tableView: (UITableView *)tableView
 canEditRowAtIndexPath: (NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    return YES;
}

- (UITableViewCellEditingStyle)tableView: (UITableView *)tableView
           editingStyleForRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void) tableView: (UITableView *)tableView
commitEditingStyle: (UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath: (NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
        [pd delete: indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [pd save];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // not implemented
    }
}

- (void) tableView: (UITableView *)tableView
moveRowAtIndexPath: (NSIndexPath *)fromIndexPath
       toIndexPath: (NSIndexPath *)toIndexPath
{
    PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
    [pd moveTo: toIndexPath.row from: fromIndexPath.row];
}


- (BOOL)     tableView: (UITableView *)tableView
 canMoveRowAtIndexPath: (NSIndexPath *)indexPath
{
    return YES;
}

@end
