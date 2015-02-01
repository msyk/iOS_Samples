//
//  ViewController.swift
//  Scrolling_Swift
//
//  Created by 新居雅行 on 2015/01/29.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var imageView: UIImageView?
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func showInfo() {
        if let scroll = scrollView {
            println("self.scrollView.bounds = "
                + NSStringFromCGRect(scroll.bounds))
            println("self.scrollView.frame = "
                + NSStringFromCGRect(scroll.frame))
        }
        if let img = imageView {
            println("self.imageView.frame = "
                + NSStringFromCGRect(img.frame))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageSize = imageView?.image?.size {
            imageView?.frame = CGRect(x: 0.0, y: 0.0,
                width: imageSize.width, height: imageSize.height)
            showInfo()
        }
    }
    
override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    showInfo()
    
    if let photoView = imageView? {
        let viewWidth = view.bounds.size.width
        let viewHeight = view.bounds.size.height
        let imageWidth = photoView.frame.size.width
        let imageHeight = photoView.frame.size.height
        
        let ratioX = imageWidth/viewWidth
        let ratioY = imageHeight/viewHeight
        println(NSString(
            format: "ratioX = %5.1f, ratioY = %5.1f",
            Float(ratioX), Float(ratioY)))
        let isBlankUpDown = (ratioX > ratioY)
        //ブランクが上下ならtrue、左右ならfalse
        println("isBlankUpDown = \(isBlankUpDown)")
        
        var justfyRatio = 1.0   //型はDouble
        //CGFloatとFloat/Doubleは互換性がなく変換が必要
        if isBlankUpDown {
            justfyRatio = 1.0 / Double(ratioX)
        } else {
            justfyRatio = 1.0 / Double(ratioY)
        }
        println("justfyRatio = \(justfyRatio)")
        
        scrollView?.contentOffset = CGPointZero
        scrollView?.contentSize
            = CGSize(width: viewWidth, height: viewHeight)
        scrollView?.minimumZoomScale = CGFloat(justfyRatio)
        scrollView?.maximumZoomScale = CGFloat(justfyRatio * 100.0)
        scrollView?.zoomScale = CGFloat(justfyRatio)
        
        var upDownBlank = 0.0, leftRightBlank = 0.0
        if isBlankUpDown {
            upDownBlank = (Double(viewHeight)
                - Double(imageHeight) * justfyRatio) / 2.0
        } else {
            leftRightBlank = (Double(viewWidth)
                - Double(imageWidth) * justfyRatio) / 2.0
        }
        scrollView?.contentInset = UIEdgeInsets(
            top: CGFloat(upDownBlank), left: CGFloat(leftRightBlank),
            bottom: CGFloat(upDownBlank), right: CGFloat(leftRightBlank))
    }
}
    
override func didRotateFromInterfaceOrientation(
    fromInterfaceOrientation: UIInterfaceOrientation) {
        adjustViews()
}
    
func scrollViewDidEndZooming(scrollView: UIScrollView,
    withView view: UIView!,
    atScale scale: CGFloat) {
        adjustViews()
}

func adjustViews() {
    if let photoView = imageView? {
        let viewWidth = view.bounds.size.width
        let viewHeight = view.bounds.size.height
        let imageWidth = photoView.frame.size.width
        let imageHeight = photoView.frame.size.height
        let ratioX = imageWidth/viewWidth
        let ratioY = imageHeight/viewHeight
        let isBlankUpDown = (ratioX > ratioY)
        
        var upDownBlank = 0.0, leftRightBlank = 0.0
        if isBlankUpDown {
            upDownBlank = (Double(viewHeight)
                - Double(imageHeight)) / 2.0
            if (upDownBlank < 0.0)  {
                upDownBlank = 0.0
            }
        } else {
            leftRightBlank = (Double(viewWidth)
                - Double(imageWidth)) / 2.0
            if (leftRightBlank < 0.0)  {
                leftRightBlank = 0.0
            }
        }
        scrollView?.contentInset = UIEdgeInsets(
            top: CGFloat(upDownBlank), left: CGFloat(leftRightBlank),
            bottom: CGFloat(upDownBlank), right: CGFloat(leftRightBlank))
    }
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

