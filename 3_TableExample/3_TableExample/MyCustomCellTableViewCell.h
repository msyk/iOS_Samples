//
//  MyCustomCellTableViewCell.h
//  3_TableExample
//
//  Created by Masayuki Nii on 2014/01/07.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomCellTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameField;
@property (nonatomic, weak) IBOutlet UILabel *phoneField;
@property (nonatomic, weak) IBOutlet UILabel *birthdayField;

@end
