//
//  ViewController.swift
//  ScreenSize
//
//  Created by 新居雅行 on 2014/09/23.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screen = UIScreen.mainScreen()
        let space = screen.coordinateSpace;
        var messageStr = "Coordinate Space: "
        messageStr += NSStringFromCGRect(space.bounds)
        messageStr += "\nBounds:"
        messageStr += NSStringFromCGRect(screen.bounds)
        messageStr += "\nApplication Frame:"
        messageStr += NSStringFromCGRect(screen.applicationFrame)
        messageStr += "\nNative Bounds:"
        messageStr += NSStringFromCGRect(screen.nativeBounds)
        messageStr += "\nNative Scale:"
        messageStr += "\(screen.nativeScale)"
        messageStr += "\nScale:"
        messageStr += "\(screen.scale)"
        message.text = messageStr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

