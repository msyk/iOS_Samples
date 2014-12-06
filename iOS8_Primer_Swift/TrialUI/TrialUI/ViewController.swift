//
//  ViewController.swift
//  TrialUI
//
//  Created by demo on 2014/11/04.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    
    @IBAction func tapButton(sender: AnyObject) {
        if imageView?.alpha < 0.5 {
            imageView?.alpha = 0.0
        } else {
            imageView?.alpha = 1.0
        }
    }
    
    @IBAction func moveSlider(sender: AnyObject)    {
        let slider = sender as UISlider
        imageView?.alpha = CGFloat(slider.value)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

