//
//  ViewController.m
//  CollectionView
//
//  Created by 新居雅行 on 2014/10/29.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"
#import "DataCellView.h"

#define CELL_WIDTH 42.0
#define CELLS_PAR_LINE 7
#define END_OF_MONTH @[@0,@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31]

@interface ViewController ()
@property (nonatomic) NSInteger startDateBias;
@property (nonatomic) NSInteger endDayNum;
@property (nonatomic) NSInteger lines;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.year = 2013;
    self.month = 10;
    
    self.navigationItem.title
    = [NSString stringWithFormat: @"%d/%d", self.year, self.month];
    
    UICollectionViewFlowLayout *fl = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    fl.minimumInteritemSpacing = (320.0 - CELL_WIDTH * CELLS_PAR_LINE) / (CELLS_PAR_LINE - 1);
    fl.sectionInset = UIEdgeInsetsMake(1.0, 0, 1.0, 0);
    
    NSDateFormatter *dtFormatter = [[NSDateFormatter alloc]init];
    [dtFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *firstDate = [dtFormatter dateFromString:
                         [NSString stringWithFormat: @"%4d-%2d-01", self.year, self.month]];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components: NSCalendarUnitWeekday
                                     fromDate: firstDate];
    self.startDateBias = comps.weekday - 1;
    self.endDayNum = [END_OF_MONTH[self.month] integerValue];
    self.lines = (self.endDayNum + self.startDateBias) / CELLS_PAR_LINE + 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    DataCellView *cell
    = [collectionView dequeueReusableCellWithReuseIdentifier: @"DATECELL"
                                                forIndexPath: indexPath];
    //cell.dateLabel.text = [NSString stringWithFormat: @"%d", indexPath.item];
    NSInteger dayNum = indexPath.item
    + indexPath.section * CELLS_PAR_LINE - self.startDateBias + 1;
    if (dayNum > 0 && dayNum <= self.endDayNum) {
        cell.dateLabel.text = [NSString stringWithFormat: @"%d", dayNum];
    } else {
        cell.dateLabel.text = @".";
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return CELLS_PAR_LINE;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    return self.lines;
}
@end
