//
//  ViewController.m
//  4_2_Calendar
//
//  Created by Masayuki Nii on 2014/01/18.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"
#import "DateCellView.h"

@interface ViewController ()

@property (nonatomic) NSInteger startDateBias;
@property (nonatomic) NSInteger endDayNum;
@property (nonatomic) NSInteger lines;

- (IBAction)tapPrev:(id)sender;
- (IBAction)tapNext:(id)sender;

@end

@interface ViewController ()

// calendar
@property (strong, nonatomic) NSCalendar       *calendar;
@property (assign, nonatomic) NSInteger         numberOfDaysInWeek;

// current month
@property (strong, nonatomic) NSDate           *month;
@property (strong, nonatomic) NSDateComponents *monthComponents;

// for collection view
@property (strong, nonatomic) NSDate           *firstDateOfCollectionView;
@property (assign, nonatomic) NSInteger         numberOfWeeksInMonth;

// formatter
@property (strong, nonatomic) NSDateFormatter  *monthFormatter;

@end

@implementation ViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.monthFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [self.monthFormatter
     setDateFormat:[NSDateFormatter dateFormatFromTemplate: @"yyyyMMMM"
                                                   options: 0
                                                    locale: locale]];
    
    self.calendar = [[NSCalendar alloc]
                     initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    
    [self.calendar setFirstWeekday:1]; // 1 = sunday, 2 = monday
    
    self.numberOfDaysInWeek
     = [self.calendar maximumRangeOfUnit: NSCalendarUnitWeekday].length;
    
    self.month = ({
        NSDate *month;
        [self.calendar rangeOfUnit: NSCalendarUnitMonth
                         startDate: &month
                          interval: NULL
                           forDate: [NSDate date]];
        month;
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout
        = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.minimumInteritemSpacing
        = (320.0 - layout.itemSize.width * self.numberOfDaysInWeek)
            / (self.numberOfDaysInWeek - 1);
    layout.minimumLineSpacing = 2.0;
    layout.sectionInset = UIEdgeInsetsMake(1.0, 0, 1.0, 0);
}

- (void)setMonth:(NSDate *)month;
{
    if (_month != month) {
        _month = month;
        
        self.title = [self.monthFormatter stringFromDate:month];
        
        NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth;
        self.monthComponents = [self.calendar components: flags
                                                fromDate: month];
        
        self.firstDateOfCollectionView = ({
            NSDate *date;
            [self.calendar rangeOfUnit: NSCalendarUnitWeekOfYear
                             startDate: &date
                              interval: NULL
                               forDate: month];
            date;
        });
        
        self.numberOfWeeksInMonth
            = [self.calendar rangeOfUnit: NSCalendarUnitWeekOfMonth
                                  inUnit: NSCalendarUnitMonth
                                 forDate: self.month].length;
        
        [self.collectionView reloadData];
    }
}

- (IBAction)tapPrev:(id)sender
{
    self.month = ({
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setMonth:-1];
        [self.calendar dateByAddingComponents: dateComponents
                                       toDate: self.month
                                      options: 0];
    });
}

- (IBAction)tapNext:(id)sender
{
    self.month = ({
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setMonth:+1];
        [self.calendar dateByAddingComponents: dateComponents
                                       toDate: self.month
                                      options: 0];
    });
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView: (UICollectionView *)collectionView
                  cellForItemAtIndexPath: (NSIndexPath *)indexPath
{
    DateCellView *cell
        = [collectionView dequeueReusableCellWithReuseIdentifier: @"DATECELL"
                                                    forIndexPath: indexPath];
    
    NSDate *date = ({
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setDay: indexPath.section * self.numberOfDaysInWeek
                                + indexPath.item];
        [self.calendar dateByAddingComponents: dateComponents
                                       toDate: self.firstDateOfCollectionView
                                      options: 0];
    });
    
    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth
                         | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *dateComponents = [self.calendar components: flags
                                                        fromDate: date];
    
    cell.dateLabel.text
        = [NSString stringWithFormat:@"%d", (int)[dateComponents day]];
    
    if ([self.monthComponents year] == [dateComponents year]
        && [self.monthComponents month] == [dateComponents month]) {
        switch ([dateComponents weekday]) {
            case 1: // sunday
                cell.dateLabel.textColor = [UIColor redColor];
                break;
            case 7: // saturday
                cell.dateLabel.textColor = [UIColor blueColor];
                break;
            default:
                cell.dateLabel.textColor = [UIColor blackColor];
                break;
        }
    } else {
        cell.dateLabel.textColor = [UIColor lightGrayColor];
    }
    
    return cell;
}

- (NSInteger)collectionView: (UICollectionView *)collectionView
     numberOfItemsInSection: (NSInteger)section
{
    return self.numberOfDaysInWeek;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return self.numberOfWeeksInMonth;
}

- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView
           viewForSupplementaryElementOfKind: (NSString *)kind
                                 atIndexPath: (NSIndexPath *)indexPath
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
