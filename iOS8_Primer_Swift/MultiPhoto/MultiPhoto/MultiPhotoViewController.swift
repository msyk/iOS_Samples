//
//  ViewController.swift
//  MultiPhoto
//
//  Created by demo on 2014/11/11.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit
import AVFoundation

class MultiPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    private var insideView: UIView?
    private var player: AVAudioPlayer?
    
    func playSound(fired: NSTimer)  {
    //    player?.play()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let musicPath = NSBundle.mainBundle()
            .pathForResource("music", ofType: "m4a")
        player = AVAudioPlayer(
            contentsOfURL: NSURL(fileURLWithPath: musicPath!),
            error: nil)
        player?.prepareToPlay()
        player?.numberOfLoops = 100;
        //        player?.play()
        NSTimer.scheduledTimerWithTimeInterval(5.0,
            target: self,
            selector: Selector("playSound:"),
            userInfo: nil,
            repeats: false)
        
        let panelWidth = 1000.0 as Float
        let panelHeight = 1000.0 as Float
        let photoFiles = ["photo1", "photo2", "photo3",
            "photo4", "photo5", "photo6"]
        let count_x = Int(sqrt(Float(photoFiles.count)))
        let count_y = photoFiles.count /  count_x
        let backRect = CGRect(x: 0.0, y: 0.0,
            width: CGFloat(panelWidth),
            height: CGFloat(panelHeight))
        
        // let x = CGRectMake(1,1,1,1)
        
        insideView = UIView(frame: backRect)
        let scrollView = view as! UIScrollView
        scrollView.addSubview(insideView!)
        scrollView.contentSize = CGSize(
            width: CGFloat(panelWidth),
            height: CGFloat(panelHeight))
        scrollView.contentOffset = CGPointZero
        var x = 0, y = 0
        let width = panelWidth / Float(count_x)
        let height = panelHeight / Float(count_y)
        for oneItem in photoFiles   {
            let path = NSBundle.mainBundle()
                .pathForResource(oneItem, ofType: "jpg")
            let imageFrame = CGRect(
                x: CGFloat(Float(x) * width),
                y: CGFloat(Float(y) * height),
                width: CGFloat(width),
                height: CGFloat(height))
            let oneImage = MyImageView(frame: imageFrame)
            oneImage.userInteractionEnabled = true;
            oneImage.image = UIImage(contentsOfFile: path!)
            insideView?.addSubview(oneImage)
            x++;
            if ( x >= count_x)  {
                x = 0
                y++
            }
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?   {
        return insideView;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

