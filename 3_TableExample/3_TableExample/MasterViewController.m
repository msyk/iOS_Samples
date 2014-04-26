//
//  MasterViewController.m
//  3_TableExample
//
//  Created by Masayuki Nii on 2014/01/05.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "PersonData.h"
#import "MyCustomCellTableViewCell.h"

@interface MasterViewController ()

@property (nonatomic, strong) NSString *fieldNameName;
@property (nonatomic, strong) NSString *fieldNamePhone;
@property (nonatomic, strong) NSString *fieldNameBirthday;

@property (strong, nonatomic) DetailViewController *detailViewController;

- (IBAction)tapInsertButton: (id)sender;

@end

@implementation MasterViewController

/*
- (void)awakeFromNib
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}
*/
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
    UINavigationController *detailArea = [self.splitViewController.viewControllers lastObject];
    self.detailViewController = (DetailViewController *)[detailArea topViewController];
    self.detailViewController.masterViewController = self;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
/*
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
*/

- (void)      tableView: (UITableView *)tableView
didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.detailViewController.detailIndex = indexPath.row;
        [self.detailViewController updateContent];
    }
}

- (void)prepareForSegue: (UIStoryboardSegue *)segue
                 sender: (id)sender
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        UITableViewCell *tappedCell = sender;
        DetailViewController *detailVC = [segue destinationViewController];
        detailVC.detailIndex = [self.tableView indexPathForCell: tappedCell].row;
        detailVC.masterViewController = self;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    return YES;
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // not implemented
    }
}

- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
       toIndexPath:(NSIndexPath *)toIndexPath
{
    PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
    [pd moveTo: toIndexPath.row from: fromIndexPath.row];
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
