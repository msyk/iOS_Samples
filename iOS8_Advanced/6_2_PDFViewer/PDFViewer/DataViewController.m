//
//  DataViewController.m
//  4_1_PDFViewer
//
//  Created by Masayuki Nii on 2014/01/13.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "DataViewController.h"
#import "PDFView.h"

@interface DataViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) PDFView *pdfView;

- (void)updateCurrentPage;

@end

@implementation DataViewController

- (void)viewDidLoad
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame: self.view.bounds];
    self.scrollView.delegate = self;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.maximumZoomScale = 100.0;
    self.scrollView.hidden = YES;
    [self.view addSubview: self.scrollView];
	
    self.pdfView = [[PDFView alloc] initWithFrame: self.view.bounds];
    [self.scrollView addSubview: self.pdfView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
#ifdef DEBUG
    NSLog( @"%s %@", __FUNCTION__, self);
#endif
    [super viewWillAppear:animated];
//    [self updateCurrentPage];
}

- (void)viewDidAppear:(BOOL)animated
{
#ifdef DEBUG
    NSLog( @"%s %@", __FUNCTION__, self);
#endif
    [super viewWillAppear:animated];
}

- (UIView *)viewForZoomingInScrollView: (UIScrollView *)scrollView       {
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    return self.pdfView;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    [self reportCurrentValues: @"didRotateFromInterfaceOrientation"];
//    [self updateCurrentPage];
}

- (void)viewDidLayoutSubviews
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
//    [super viewDidLayoutSubviews];
    [self updateCurrentPage];
}

- (void)updateCurrentPage
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.zoomScale = 1.0;
    
    if ( self.pageRef != nil ) {
        self.pdfView.pageRef = self.pageRef;
        CGRect pageRect = CGPDFPageGetBoxRect(self.pdfView.pageRef, kCGPDFMediaBox );
        self.scrollView.frame = CGRectInset(self.view.bounds, 10.0, 10.0);
        self.pdfView.frame = pageRect;
        
        CGFloat ratioX = self.pdfView.frame.size.width / self.scrollView.bounds.size.width;
        CGFloat ratioY = self.pdfView.frame.size.height / self.scrollView.bounds.size.height;
        BOOL isBlankUpDown = (ratioX > ratioY);
        CGFloat justfyRatio = isBlankUpDown ? (1.0 / ratioX) :(1.0 / ratioY);
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width,
                                                 self.scrollView.bounds.size.height);
        self.scrollView.minimumZoomScale = justfyRatio;
        self.scrollView.zoomScale = justfyRatio;
        
        CGFloat upDownBlank = 0.0, leftRightBlank = 0.0;
        if (isBlankUpDown)  {
            upDownBlank = (self.scrollView.bounds.size.height - self.pdfView.frame.size.height) / 2.0;
            if (upDownBlank < 0)    {
                upDownBlank = 0.0;
            }
        } else {
            leftRightBlank = (self.scrollView.bounds.size.width - self.pdfView.frame.size.width) / 2.0;
            if (leftRightBlank < 0)    {
                leftRightBlank = 0.0;
            }
        }
        self.scrollView.contentInset = UIEdgeInsetsMake(upDownBlank, leftRightBlank,
                                                        upDownBlank, leftRightBlank);
        
        self.scrollView.hidden = NO;
    }
    [self reportCurrentValues: @"after updateCurrentPage"];
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
    NSLog(@"self.pdfView.frame           = %@", NSStringFromCGRect(self.pdfView.frame));
    NSLog(@"self.pdfView.transform       = %@", NSStringFromCGAffineTransform(self.pdfView.transform));
#endif
}


@end
