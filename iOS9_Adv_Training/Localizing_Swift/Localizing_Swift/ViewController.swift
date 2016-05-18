//
//  ViewController.swift
//  Localizing_Swift
//
//  Created by 新居雅行 on 2015/01/29.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var input: UITextField?
    @IBOutlet private var message: UITextView?
    
@IBAction func tapButton(sender: UIButton) {
    if let inputText = input?.text {
        message?.text = NSString(format:
            NSLocalizedString("message1", comment: ""), inputText) as String
    }
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

