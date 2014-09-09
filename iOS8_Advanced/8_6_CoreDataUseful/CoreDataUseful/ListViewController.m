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
@property(nonatomic, strong) NSArray *headLetters;
@property(nonatomic, strong) NSMutableDictionary *fetchedArrays;

@end

@implementation ListViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.headLetters = @[@"A", @"あ", @"か", @"さ", @"た", @"な", @"は", @"ま", @"や", @"ら", @"わ"];
    self.fetchedArrays = [NSMutableDictionary dictionary];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headLetters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *groupLetter = self.headLetters[section];
    if (self.fetchedArrays[groupLetter] == nil) {
        NSString *endLetter = section + 1 < self.headLetters.count ? self.headLetters[section + 1] : @"ん";
        self.fetchedArrays[groupLetter] = [self.localDB selectedPeopleFrom: groupLetter
                                                                        to: endLetter
                                                                   orderBy: @"phonetic"];
    }
    return [self.fetchedArrays[groupLetter] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"CELL"
                                                            forIndexPath: indexPath];
    NSString *groupLetter = self.headLetters[indexPath.section];
    People *myself = self.fetchedArrays[groupLetter][indexPath.row];
    
    cell.textLabel.text = myself.name;
    cell.detailTextLabel.text = [myself.age stringValue];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.headLetters[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return @[@"アルファベット", @"あ行", @"か行", @"さ行",
             @"た行", @"な行", @"は行", @"ま行", @"や行以降"];
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}
/*
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index / 2;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return @[@"A", @"1", @"2", @"3", @"4", @"5", @"6", @"7"];
}
*/



@end
