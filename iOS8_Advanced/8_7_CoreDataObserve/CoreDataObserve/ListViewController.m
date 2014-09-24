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

@property (nonatomic, strong) LocalDB *localDB;
@property (nonatomic, strong) NSFetchedResultsController *fechedController;

- (void)addRecord: (NSTimer *)timer;
- (void)editRecord: (NSTimer *)timer;
- (void)deleteRecord: (NSTimer *)timer;

@end

@implementation ListViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.localDB = [[LocalDB alloc]init];
    self.fechedController = self.localDB.fetchResultController;
    self.fechedController.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                      target: self
                                                    selector: @selector(addRecord:)
                                                    userInfo: nil
                                                     repeats: YES];
    NSTimer *timer2 = [NSTimer scheduledTimerWithTimeInterval: 22.0
                                                       target: self
                                                     selector: @selector(deleteRecord:)
                                                     userInfo: nil
                                                      repeats: YES];
    if (timer == nil || timer2 == nil)   {
        NSLog( @"What's wrong!?");
    }
}

- (void)addRecord: (NSTimer *)timer
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    [self.localDB addPoeople: [[NSDate date] description]];
    
    NSTimer *timers = [NSTimer scheduledTimerWithTimeInterval: 2.0
                                                       target: self
                                                     selector: @selector(editRecord:)
                                                     userInfo: nil
                                                      repeats: NO];
    if (timers == nil)   {
        NSLog( @"What's wrong!?");
    }
}

- (void)editRecord: (NSTimer *)timer
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    People *person = self.fechedController.fetchedObjects[0];
    person.phonetic = @"Edited";
}

- (void)deleteRecord: (NSTimer *)timer
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    [self.localDB deletePeople: self.fechedController.fetchedObjects[3]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView: (UITableView *)tableView
 numberOfRowsInSection: (NSInteger)section
{
    return self.fechedController.fetchedObjects.count;
}

- (UITableViewCell *)tableView: (UITableView *)tableView
         cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog(@"%s indexPath = %@", __FUNCTION__, indexPath);
#endif
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"
                                                            forIndexPath: indexPath];
    People *myself = self.fechedController.fetchedObjects[indexPath.row];
    cell.textLabel.text = myself.name;
    cell.detailTextLabel.text = myself.phonetic;
    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate Implementations

- (void)controllerWillChangeContent: (NSFetchedResultsController *)controller
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    [self.tableView beginUpdates];
}

- (void)controller: (NSFetchedResultsController *)controller
  didChangeSection: (id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex: (NSUInteger)sectionIndex
     forChangeType: (NSFetchedResultsChangeType)type
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"type = %u, sectionInfo=%@", type, sectionInfo);
#endif
    switch(type){
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections: [NSIndexSet indexSetWithIndex:sectionIndex]
                         withRowAnimation : UITableViewRowAnimationFade];
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections: [NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation: UITableViewRowAnimationFade];
        default: break;
    }
}


- (void)controller: (NSFetchedResultsController *)controller
   didChangeObject: (id)anObject
       atIndexPath: (NSIndexPath *)indexPath
     forChangeType: (NSFetchedResultsChangeType)type
      newIndexPath: (NSIndexPath *)newIndexPath
{
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"type = %u", type);
    NSLog(@"atIndexPath = %@, newIndexPath = %@", indexPath, newIndexPath);
    NSLog(@"anObject = %@", anObject);
    NSLog(@"fetchedObjects.count = %d", self.fechedController.fetchedObjects.count);
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


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
#ifdef DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
    [self.tableView endUpdates];
}

@end
