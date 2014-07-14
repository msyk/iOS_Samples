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
#ifdef SESSION5
@property(nonatomic, strong) NSArray *headLetters;
@property(nonatomic, strong) NSMutableDictionary *fetchedArrays;
#endif
@end

@implementation ListViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
    
#ifdef SESSION5
    self.headLetters = @[@"A", @"あ", @"か", @"さ", @"た", @"な", @"は", @"ま", @"や", @"ら", @"わ"];
    self.fetchedArrays = [NSMutableDictionary dictionary];
    
#endif
    
    self.localDB = [[LocalDB alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#ifdef SESSION3
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
    cell.detailTextLabel.text = myself.phonetic;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Company *company = self.localDB.selectedData[section];
    return company.company;
}
#endif

#ifdef SESSION4
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
    cell.detailTextLabel.text = myself.group;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Company *company = self.localDB.selectedData[section];
    return company.company;
}
#endif

#ifdef SESSION5
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headLetters.count;
}

- (NSInteger)tableView: (UITableView *)tableView
 numberOfRowsInSection: (NSInteger)section
{
    NSString *groupLetter = self.headLetters[section];
    if (self.fetchedArrays[groupLetter] == nil) {
        NSString *endLetter = section + 1 < self.headLetters.count ? self.headLetters[section + 1] : @"ん";
        self.fetchedArrays[groupLetter]
        = [self.localDB selectedPeopleFrom: groupLetter
                                        to: endLetter
                                   orderBy: @"phonetic"];
    }
    return [self.fetchedArrays[groupLetter] count];
}

- (UITableViewCell *)tableView: (UITableView *)tableView
         cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"
                                                            forIndexPath: indexPath];
    NSString *groupLetter = self.headLetters[indexPath.section];
    People *myself = self.fetchedArrays[groupLetter][indexPath.row];
    
    cell.textLabel.text = myself.name;
    cell.detailTextLabel.text = myself.phonetic;
    
    return cell;
}

- (NSString *) tableView: (UITableView *)tableView
 titleForHeaderInSection: (NSInteger)section
{
    return self.headLetters[section];
}

- (NSArray *)sectionIndexTitlesForTableView: (UITableView *)tableView
{
    return @[@"アルファベット", @"あ行", @"か行", @"さ行",
             @"た行", @"な行", @"は行", @"ま行", @"や行以降"];
}


- (NSInteger)      tableView: (UITableView *)tableView
 sectionForSectionIndexTitle: (NSString *)title
                     atIndex: (NSInteger)index
{
    return index;
}

/*
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return @[ @"A", @"・", @"G", @"・", @"K", @"・", @"P", @"・", @"S", @"・", @"Z" ];
}

- (NSInteger)      tableView: (UITableView *)tableView
 sectionForSectionIndexTitle: (NSString *)title
                     atIndex: (NSInteger)index
{
    NSInteger result[] = {0,3,6,8,10,13,15,18,20,22,25};
    return result[index];
}
 */
#endif

@end
