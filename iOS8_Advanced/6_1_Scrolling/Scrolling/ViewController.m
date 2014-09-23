//
//  ViewController.m
//  2_4_Scrolling
//
//  Created by Masayuki Nii on 2013/12/27.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic) CGFloat ratioX;
@property (nonatomic) CGFloat ratioY;
@property (nonatomic) BOOL isBlankUpDown;

- (void)setupContentInset;
- (void)setupRatio;
- (void)updateSizeProps;
- (void)reportCurrentValues: (NSString *)label;

@end

@implementation ViewController

- (void)viewDidLoad
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [super viewDidLoad];
    
    NSString *imageFile = [[NSBundle mainBundle] pathForResource: @"1000057"
                                                          ofType: @"JPG"];
    UIImage *image = [UIImage imageWithContentsOfFile: imageFile];
    self.imageView = [[UIImageView alloc] initWithImage: image];
    [self.scrollView addSubview: self.imageView];
    
//    self.scrollView.frame = self.view.bounds;
//    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 100.0;
    self.scrollView.minimumZoomScale = 0.01;
    
    [self reportCurrentValues: @"viewDidLoad"];
}

- (void)viewDidAppear:(BOOL)animated
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [super viewDidAppear: YES];
    [self reportCurrentValues: @"viewDidAppear-before"];
    
    [self setupRatio];
    [self setupContentInset];
    
    [self reportCurrentValues: @"viewDidAppear-after"];
}

- (void)viewWillLayoutSubviews
{
//    CGRect scrollRect = self.scrollView.frame;
//    scrollRect.origin.y += self.topLayoutGuide.length;
//    self.scrollView.frame = scrollRect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    return self.imageView;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
                       withView:(UIView *)view
                        atScale:(CGFloat)scale
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [self setupContentInset];
}

- (void)reportCurrentValues: (NSString *)label
{
#ifdef DEBUG
    NSLog(@"============================== %@", label);
    NSLog(@"self.view.bounds             = %@", NSStringFromCGRect(self.view.bounds));
    NSLog(@"self.view.frame              = %@", NSStringFromCGRect(self.view.frame));
    NSLog(@"self.view.transform          = %@", NSStringFromCGAffineTransform(self.view.transform));
    NSLog(@"self.scrollView.bounds       = %@", NSStringFromCGRect(self.scrollView.bounds));
    NSLog(@"self.scrollView.frame        = %@", NSStringFromCGRect(self.scrollView.frame));
    NSLog(@"self.scrollView.transform    = %@", NSStringFromCGAffineTransform(self.scrollView.transform));
    NSLog(@"self.scrollView.contentInset = %@", NSStringFromUIEdgeInsets(self.scrollView.contentInset));
    NSLog(@"self.imageView.frame         = %@", NSStringFromCGRect(self.imageView.frame));
    NSLog(@"self.imageView.transform     = %@", NSStringFromCGAffineTransform(self.imageView.transform));
#endif
}

- (void)updateSizeProps
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    self.ratioX = self.imageView.frame.size.width / self.scrollView.bounds.size.width;
    self.ratioY = self.imageView.frame.size.height / self.scrollView.bounds.size.height;
#ifdef DEBUG
    NSLog(@"ratioX = %6.3f, ratioY = %6.3f", self.ratioX, self.ratioY);
#endif
    self.isBlankUpDown = (self.ratioX > self.ratioY);
#ifdef DEBUG
    NSLog(@"isBlankUpDown = %@", self.isBlankUpDown ? @"YES" : @"NO");
#endif
    
}

- (void)setupContentInset
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [self updateSizeProps];
    CGFloat upDownBlank = 0.0, leftRightBlank = 0.0;
    if (self.isBlankUpDown)  {
        upDownBlank = (self.scrollView.bounds.size.height - self.imageView.frame.size.height) / 2.0;
        if (upDownBlank < 0)    {
            upDownBlank = 0.0;
        }
    } else {
        leftRightBlank = (self.scrollView.bounds.size.width - self.imageView.frame.size.width) / 2.0;
        if (leftRightBlank < 0)    {
            leftRightBlank = 0.0;
        }
    }
    self.scrollView.contentInset
    = UIEdgeInsetsMake(upDownBlank, leftRightBlank,
                       upDownBlank, leftRightBlank);
    
    [self reportCurrentValues: @"setupContentInset"];
}

- (void)setupRatio
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    self.scrollView.zoomScale = 1.0;
    
    [self updateSizeProps];
    
    CGFloat justfyRatio = 1.0;
    if (self.isBlankUpDown)  {
        justfyRatio = 1.0 / self.ratioX;
    } else {
        justfyRatio = 1.0 / self.ratioY;
    }
#ifdef DEBUG
    NSLog(@"justfyRatio = %6.3f", justfyRatio);
#endif
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width,
                                             self.scrollView.bounds.size.height);
    self.scrollView.minimumZoomScale = justfyRatio;
    self.scrollView.maximumZoomScale = justfyRatio * 100.0;
    self.scrollView.zoomScale = justfyRatio;
    
    [self reportCurrentValues: @"setupRatio"];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [self reportCurrentValues: @"didRotateFromInterfaceOrientation"];
    [self setupRatio];
    [self setupContentInset];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
