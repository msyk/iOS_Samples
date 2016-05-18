//
//  MovieViewController.swift
//  MoviePlayer
//
//  Created by Masayuki Nii on 2016/01/31.
//  Copyright © 2016年 msyk.net. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MovieViewController: AVPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = NSBundle.mainBundle()
        let movieFile = bundle.URLForResource("samplemovie", withExtension: "m4v")
        self.player = AVPlayer(URL: movieFile!)
        
    }
    
}
