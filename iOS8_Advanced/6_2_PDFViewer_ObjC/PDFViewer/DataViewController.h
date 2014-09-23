//
//  DataViewController.h
//  4_1_PDFViewer
//
//  Created by Masayuki Nii on 2014/01/13.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController <UIScrollViewDelegate>

@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) __attribute__((NSObject)) CGPDFPageRef pageRef;

@end
