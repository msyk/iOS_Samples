//
//  DetailViewController.m
//  3_TableExample
//
//  Created by Masayuki Nii on 2014/01/05.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "DetailViewController.h"

#import "AppDelegate.h"
#import "PersonData.h"
#import "MasterViewController.h"

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UITextField *phoneField;
@property (nonatomic, weak) IBOutlet UITextField *birthdayField;
@property (nonatomic, weak) IBOutlet UITextField *ageField;

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@property (nonatomic, strong) NSArray *fieldLabels;
@property (nonatomic, strong) NSArray *fieldNames;
@property (nonatomic, strong) NSMutableDictionary *currentPerson;
@property (nonatomic, strong, readonly) NSDictionary *currentCells;

- (IBAction)tapSaveButton: (id)sender;

- (void)setCells;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setCells
{
    self.nameField.text = self.currentPerson[self.fieldNames[0]];
    self.phoneField.text = self.currentPerson[self.fieldNames[1]];
    self.birthdayField.text = self.currentPerson[self.fieldNames[2]];
    self.ageField.text = [self.currentPerson[self.fieldNames[3]] stringValue];
}

- (NSDictionary *)currentCells //**Getter**
{
    return  @{self.fieldNames[0]: self.nameField.text,
              self.fieldNames[1]: self.phoneField.text,
              self.fieldNames[2]: self.birthdayField.text,
              self.fieldNames[3]: [NSNumber numberWithInteger:
                                   [self.ageField.text integerValue]]};
}

- (void)updateContent
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
    self.navigationItem.title = pd.people[self.detailIndex][self.fieldNames[0]];
    self.currentPerson = [NSMutableDictionary dictionaryWithDictionary:
                          pd.people[self.detailIndex]];
    
    [self setCells];
    
//    if (self.masterPopoverController != nil) {
//        [self.masterPopoverController dismissPopoverAnimated:YES];
//    }
}

- (void)viewDidLoad
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
    self.fieldNames = pd.fieldNames;
    self.fieldLabels = @[@"Name", @"Phone", @"Birthday", @"Age"];

}

- (void)viewDidAppear: (BOOL)animated
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [super viewDidAppear: animated];
    [self updateContent];
}

- (void)didReceiveMemoryWarning
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (NSString *)tableView: (UITableView *)tableView
titleForHeaderInSection: (NSInteger)section
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    return self.fieldLabels[section];
}

- (IBAction)tapSaveButton: (id)sender
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    NSDictionary *cellData = self.currentCells;
    self.currentPerson = [NSMutableDictionary dictionaryWithDictionary: cellData];
    PersonData *pd = ((AppDelegate *)UIApplication.sharedApplication.delegate).personData;
    [pd setRecord: cellData atIndex: self.detailIndex];
    BOOL saveResult = [pd save];
    if ( ! saveResult ) {
        NSLog( @"File save failed." );
    }
    
    NSArray *updateCells = @[[NSIndexPath indexPathForItem: self.detailIndex inSection: 0]];
    [self.masterViewController.tableView reloadRowsAtIndexPaths: updateCells
                                               withRowAnimation: UITableViewRowAnimationNone];
}

#pragma mark - Split view

- (void)splitViewController: (UISplitViewController *)splitController
     willHideViewController: (UIViewController *)viewController
          withBarButtonItem: (UIBarButtonItem *)barButtonItem
       forPopoverController: (UIPopoverController *)popoverController
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController: (UISplitViewController *)splitController
     willShowViewController: (UIViewController *)viewController
  invalidatingBarButtonItem: (UIBarButtonItem *)barButtonItem
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
