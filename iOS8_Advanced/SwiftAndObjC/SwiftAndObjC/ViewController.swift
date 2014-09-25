//
//  ViewController.swift
//  SwiftAndObjC
//
//  Created by 新居雅行 on 2014/09/24.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tc = TestClass();
        tc.name = "As I am";
        println(tc.deluxName("Great! "))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

