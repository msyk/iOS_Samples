//
//  MyImageView.m
//  MultiPhoto
//
//  Created by demo on 2014/09/12.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "MyImageView.h"

@interface MyImageView ()

@property (nonatomic) CGRect previousFrame;

@end

@implementation MyImageView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __FUNCTION__);
    
    if (event.allTouches.count == 1)    {
        self.previousFrame = self.frame;
        CGRect shrinked = CGRectMake(self.frame.origin.x + self.frame.size.width / 2,
                                     self.frame.origin.y + self.frame.size.height / 2,
                                     0.0, 0.0);
        [UIView animateWithDuration: 1.0
                         animations: ^(void){self.frame = shrinked;}];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __FUNCTION__);
    
    [UIView animateWithDuration: 1.0
                     animations: ^(void){self.frame = self.previousFrame;}];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __FUNCTION__);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
