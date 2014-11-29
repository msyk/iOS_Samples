//
//  ViewController.m
//  Scrolling
//
//  Created by 新居雅行 on 2014/10/29.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)showInfo  {
    NSLog(@"self.view.bounds = %@", NSStringFromCGRect(self.view.bounds));
    NSLog(@"self.view.frame = %@", NSStringFromCGRect(self.view.frame));
    NSLog(@"self.scrollView.bounds = %@",
          NSStringFromCGRect(self.scrollView.bounds));
    NSLog(@"self.scrollView.frame = %@", NSStringFromCGRect(self.scrollView.frame));
    NSLog(@"self.imageView.frame = %@", NSStringFromCGRect(self.imageView.frame));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.frame = CGRectMake(0, 0,
                                      self.imageView.image.size.width,
                                      self.imageView.image.size.height);
    [self showInfo];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear: YES];
    
    [self showInfo];
    
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height;
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat ratioX = imageWidth / viewWidth;
    CGFloat ratioY = imageHeight / viewHeight;
    NSLog(@"ratioX = %5.1f, ratioY = %5.1f", ratioX, ratioY);
    
    //ブランクが上下ならYES、左右ならNO
    BOOL isBlankUpDown = (ratioX > ratioY);
    NSLog(@"isBlankUpDown = %@", isBlankUpDown ? @"YES" : @"NO");
    
    CGFloat justfyRatio = 1.0;
    if (isBlankUpDown)  {
        justfyRatio = 1.0 / ratioX;
    } else {
        justfyRatio = 1.0 / ratioY;
    }
    NSLog(@"justfyRatio = %5.1f", justfyRatio);
    
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.contentSize = CGSizeMake(viewWidth, viewHeight);
    self.scrollView.minimumZoomScale = justfyRatio;
    self.scrollView.maximumZoomScale = justfyRatio * 100.0;
    self.scrollView.zoomScale = justfyRatio;
    CGFloat upDownBlank = 0.0, leftRightBlank = 0.0;
    if (isBlankUpDown)  {
        upDownBlank = (viewHeight - imageHeight * justfyRatio) / 2.0;
    } else {
        leftRightBlank = (viewWidth - imageWidth * justfyRatio) / 2.0;
    }
    self.scrollView.contentInset
    = UIEdgeInsetsMake(upDownBlank, leftRightBlank,
                       upDownBlank, leftRightBlank);
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
                       withView:(UIView *)view
                        atScale:(float)scale
{
    [self adjustViews];
}

- (void)adjustViews
{
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height;
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat ratioX = imageWidth / viewWidth;
    CGFloat ratioY = imageHeight / viewHeight;
    BOOL isBlankUpDown = (ratioX > ratioY);
    
    CGFloat upDownBlank = 0.0, leftRightBlank = 0.0;
    if (isBlankUpDown)  {
        upDownBlank = (viewHeight - imageHeight) / 2.0;
        if (upDownBlank < 0)    {
            upDownBlank = 0.0;
        }
    } else {
        leftRightBlank = (viewWidth - imageWidth) / 2.0;
        if (leftRightBlank < 0)    {
            leftRightBlank = 0.0;
        }
    }
    self.scrollView.contentInset
    = UIEdgeInsetsMake(upDownBlank, leftRightBlank,
                       upDownBlank, leftRightBlank);

}

- (void)didRotateFromInterfaceOrientation:
(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self adjustViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
