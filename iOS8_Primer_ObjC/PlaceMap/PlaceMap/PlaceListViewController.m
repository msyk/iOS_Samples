//
//  PlaceListViewController.m
//  PlaceMap
//
//  Created by demo on 2014/09/14.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "PlaceListViewController.h"
#import "AppDelegate.h"
#import "PlaceDatabase.h"
#import "MapDisplayViewController.h"

@interface PlaceListViewController ()

@end

@implementation PlaceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView: (UITableView *)tableView
 numberOfRowsInSection: (NSInteger)section
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSArray *places = appDelegate.placeDB.places;
    
    return places.count;
}


- (UITableViewCell *)tableView: (UITableView *)tableView
         cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSArray *places = appDelegate.placeDB.places;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"PLACECELL"
                                                            forIndexPath: indexPath];
    cell.textLabel.text = [NSString stringWithFormat: @"%@ [%@]",
                           places[indexPath.row][@"pref"], places[indexPath.row][@"name"]];
    //    cell.textLabel.text = places[indexPath.row][@"name"];
    
    return cell;
}

//- (void)       tableView: (UITableView *)tableView
// didSelectRowAtIndexPath: (NSIndexPath *)indexPath
//{
//    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
//        UISplitViewController *splitVC = self.splitViewController;
//        UINavigationController *detainNC = (UINavigationController *)splitVC.viewControllers[1];
//        MapDisplayViewController *mapDisplayVC = (MapDisplayViewController *)detainNC.topViewController;
//        mapDisplayVC.selectedIndex = self.tableView.indexPathForSelectedRow.row;
//        [mapDisplayVC updateContent];
//    }
//}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    UINavigationController *detailNC = (UINavigationController *)[segue destinationViewController];
    MapDisplayViewController *destVC = (MapDisplayViewController *)detailNC.topViewController;
    destVC.selectedIndex = self.tableView.indexPathForSelectedRow.row;
    [destVC updateContent];
}


@end
