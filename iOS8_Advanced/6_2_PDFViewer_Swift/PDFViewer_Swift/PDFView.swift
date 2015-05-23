//
//  PDFView.swift
//  PDFViewer_Swift
//
//  Created by Masayuki Nii on 2015/05/24.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

class PDFView: UIView {

    var pageRef : CGPDFPageRef?

    required override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        if ( self.pageRef != nil ) {
            let context = UIGraphicsGetCurrentContext();
            CGContextSaveGState(context);
            
            //       CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
            //        CGInterpolationQuality x = CGContextGetInterpolationQuality (context);
            //        NSLog(@"CGInterpolationQuality=%d", x);
            
            
            CGContextSetFillColorWithColor( context, UIColor.whiteColor().CGColor )
            UIRectFill( rect )
            let pageRect = CGPDFPageGetBoxRect( self.pageRef, kCGPDFMediaBox )
            
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

}
