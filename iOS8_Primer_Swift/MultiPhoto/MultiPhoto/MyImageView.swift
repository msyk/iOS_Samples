//
//  MyImangeView.swift
//  MultiPhoto
//
//  Created by demo on 2014/11/11.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class MyImageView: UIImageView {
    
    private var previousFrame: CGRect?
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(__FUNCTION__)
        
        if event.allTouches()?.count == 1 {
            previousFrame = frame;
//            let shrinked = CGRectMake(
//                frame.origin.x + frame.size.width / 2,
//                frame.origin.y + frame.size.height / 2,
//                0.0, 0.0)
            let shrinked = CGRect(
                x: frame.origin.x + frame.size.width / 2,
                y: frame.origin.y + frame.size.height / 2,
                width: 0.0,
                height: 0.0)
            UIView.animateWithDuration( 1.0,
                animations: {self.frame = shrinked})
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(__FUNCTION__)

        UIView.animateWithDuration( 1.0,
            animations: {
                if let changedFrame = self.previousFrame {
                    self.frame = changedFrame
                }
        })
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(__FUNCTION__)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
