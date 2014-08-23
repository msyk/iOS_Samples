//
//  MyCustomCellTableViewCell.m
//  3_TableExample
//
//  Created by Masayuki Nii on 2014/01/07.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "MyCustomCellTableViewCell.h"

@interface MyCustomCellTableViewCell()
@end

@implementation MyCustomCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
