//
//  ViewController.swift
//  MoviePlayer
//
//  Created by Masayuki Nii on 2016/01/31.
//  Copyright © 2016年 msyk.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var guideView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieVC = self.storyboard?
            .instantiateViewControllerWithIdentifier("MOVIE"),
            gView = self.guideView{
                self.addChildViewController(movieVC);
                gView.addSubview(movieVC.view);
                let guideRect = gView.bounds
                movieVC.view.frame = guideRect
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

