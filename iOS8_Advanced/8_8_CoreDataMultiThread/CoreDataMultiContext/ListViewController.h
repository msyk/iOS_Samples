//
//  ViewController.h
//  6_CoreDataSample
//
//  Created by Masayuki Nii on 2014/02/02.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ListViewController : UITableViewController
                <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@end
