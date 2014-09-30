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
    <UITableViewDataSource, UITableViewDelegate,
     NSFetchedResultsControllerDelegate>

@property(nonatomic, strong) LocalDB *localDB;
@property (nonatomic, strong)
    NSFetchedResultsController *fechedController;

@end

@implementation ListViewController

- (void)awakeFromNib
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    [super awakeFromNib];
    
    self.localDB = [[LocalDB alloc]init];
    self.fechedController = self.localDB.fetchResultController;
    self.fechedController.delegate = self;
}

- (void)viewDidLoad
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    [super viewDidLoad];
}

- (IBAction)tapLoadButton:(id)sender
{
    [self.localDB batchLoad];
}

- (IBAction)tapClearButton:(id)sender
{
    [self.localDB batchClear];
}

- (void)controllerWillChangeContent: (NSFetchedResultsController *)controller
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    [self.tableView beginUpdates];
}

- (void)controller: (NSFetchedResultsController *)controller
   didChangeObject: (id)anObject
       atIndexPath: (NSIndexPath *)indexPath
     forChangeType: (NSFetchedResultsChangeType)type
      newIndexPath: (NSIndexPath *)newIndexPath
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths: @[newIndexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths: @[indexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths: @[indexPath]
                                  withRowAnimation: UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths: @[indexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths: @[newIndexPath]
                                  withRowAnimation: UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent: (NSFetchedResultsController *)controller {
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    [self.tableView endUpdates];
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
    NSLog(@"%s %d", __FUNCTION__,  (int)self.fechedController.fetchedObjects.count);
#endif
    return self.fechedController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"
                                                            forIndexPath: indexPath];
    People *myself = [self.fechedController objectAtIndexPath: indexPath];
    cell.textLabel.text = myself.name;
    cell.detailTextLabel.text = myself.company.company;
    return cell;
}

@end
