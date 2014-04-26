//
//  PDFView.h
//  BookViewer
//
//  Created by Masayuki Nii on 11/11/24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFView : UIView

@property (weak, nonatomic) __attribute__((NSObject)) CGPDFPageRef pageRef;

@end
