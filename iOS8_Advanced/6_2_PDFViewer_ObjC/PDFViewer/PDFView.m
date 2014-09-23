//
//  PDFView.m
//  BookViewer
//
//  Created by Masayuki Nii on 11/11/24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView

- (id)initWithFrame: (CGRect)frame
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect: (CGRect)rect
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__);
#endif
    if ( self.pageRef != nil ) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
 //       CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
//        CGInterpolationQuality x = CGContextGetInterpolationQuality (context);
//        NSLog(@"CGInterpolationQuality=%d", x);

        
        CGContextSetFillColorWithColor( context, [UIColor whiteColor].CGColor );
        UIRectFill( rect );
        CGRect pageRect = CGPDFPageGetBoxRect( self.pageRef, kCGPDFMediaBox );
        
        CGContextConcatCTM (context, 
                            CGPDFPageGetDrawingTransform (self.pageRef, 
                                                          kCGPDFMediaBox, 
                                                          pageRect, 0, true ));
        CGContextConcatCTM (context, 
                            CGAffineTransformMakeTranslation( 0, pageRect.size.height) );
        CGContextConcatCTM (context, 
                            CGAffineTransformMakeScale( 1.0, -1.0 ) );
        CGContextClipToRect ( context, rect );
        
        CGContextDrawPDFPage(context, self.pageRef);
        CGContextRestoreGState(context);
    }
}

@end
