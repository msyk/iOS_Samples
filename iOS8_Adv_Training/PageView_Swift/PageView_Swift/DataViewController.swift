//
//  DataViewController.swift
//  PageView_Swift
//
//  Created by 新居雅行 on 2015/01/29.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: AnyObject?
    @IBOutlet weak var photoView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    if let obj: AnyObject = dataObject {
        self.dataLabel!.text = obj.description
        let imagePath = NSBundle.mainBundle()
            .pathForResource(obj.description, ofType: "jpg")
        photoView?.image = UIImage(contentsOfFile: imagePath!)
        photoView?.contentMode = .ScaleAspectFit
    } else {
        self.dataLabel!.text = ""
    }
}
}

