//
//  ViewController.m
//  4_2_Calendar
//
//  Created by Masayuki Nii on 2014/01/18.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"
#import "DateCellView.h"

#define CELL_WIDTH 42.0
#define CELLS_PAR_LINE 7

@interface ViewController ()

@property (nonatomic) NSInteger startDateBias;
@property (nonatomic) NSInteger endDayNum;
@property (nonatomic) NSInteger lines;

- (IBAction)tapPrev:(id)sender;
- (IBAction)tapNext:(id)sender;

- (void)updateCalendar;
- (NSInteger)daysOfMonth: (NSInteger)m ofYear: (NSInteger)y;

@end

@implementation ViewController

- (void)viewDidLoad
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [super viewDidLoad];
    
    self.year = 2013;
    self.month = 10;
    [self updateCalendar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateCalendar
{
    self.navigationItem.title = [NSString stringWithFormat: @"%d/%d", self.year, self.month];
    
    UICollectionViewFlowLayout *fl = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    fl.minimumInteritemSpacing = (320.0 - CELL_WIDTH * CELLS_PAR_LINE) / (CELLS_PAR_LINE - 1);
    fl.minimumLineSpacing = 2.0;
    fl.sectionInset = UIEdgeInsetsMake(1.0, 0, 1.0, 0);

    NSDateFormatter *dtFormatter = [[NSDateFormatter alloc]init];
    [dtFormatter setDateFormat: @"yyyy-MM-dd"];
    NSString *firstDateString = [NSString stringWithFormat:
                                 @"%4d-%2d-01", self.year, self.month];
    NSDate *firstDate = [dtFormatter dateFromString:firstDateString];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components: (NSCalendarUnit)kCFCalendarUnitWeekday
                                     fromDate: firstDate];
    self.startDateBias = comps.weekday - 1;
    self.endDayNum = [self daysOfMonth: self.month ofYear: self.year];
    self.lines = (self.endDayNum + self.startDateBias) / CELLS_PAR_LINE;
    if (self.endDayNum + self.startDateBias > self.lines * CELLS_PAR_LINE)  {
        self.lines++;
    }
}

- (NSInteger)daysOfMonth: (NSInteger)m ofYear: (NSInteger)y
{
    if (m != 2) {
        return [@[@0,@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31][m] integerValue];
    }
    if (y % 4 == 0) {
        if ( y % 100 == 0)  {
            if ( y % 400 == 0)  {
                return 29;
            } else {
                return 28;
            }
        } else {
            return 29;
        }
    } else {
        return 28;
    }
}

- (IBAction)tapPrev:(id)sender
{
    self.month--;
    if (self.month < 1)    {
        self.month = 12;
        self.year--;
    }
    [self updateCalendar];
    [self.collectionView reloadData];
}

- (IBAction)tapNext:(id)sender
{
    self.month++;
    if (self.month > 12)    {
        self.month = 1;
        self.year++;
    }
    [self updateCalendar];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    DateCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"DATECELL"
                                                                   forIndexPath:indexPath];
    //    cell.dateLabel.text = [NSString stringWithFormat: @"%d", indexPath.item];
    NSInteger dayNum = indexPath.item + indexPath.section * CELLS_PAR_LINE - self.startDateBias + 1;
    if (dayNum > 0 && dayNum <= self.endDayNum) {
        cell.dateLabel.text = [NSString stringWithFormat: @"%d", dayNum];
        if (indexPath.item == 0) {
            cell.dateLabel.textColor = [UIColor redColor];
        } else if (indexPath.item == 6) {
            cell.dateLabel.textColor = [UIColor blueColor];
        }else {
            cell.dateLabel.textColor = [UIColor blackColor];
        }
    } else {
        cell.dateLabel.text = @".";
        cell.dateLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    //    return 7;
    return CELLS_PAR_LINE;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    //    return 5;
    return self.lines;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return NO;
}

- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return nil;
}
@end
