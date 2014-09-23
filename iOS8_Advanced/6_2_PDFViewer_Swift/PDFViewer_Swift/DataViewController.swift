//
//  DataViewController.swift
//  PDFViewer_Swift
//
//  Created by 新居雅行 on 2014/09/23.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UIScrollViewDelegate {

    var page: Int = -1
    var pageRef: CGPDFPageRef?
    
    private var scrollView: UIScrollView?
    private var pdfView: PDFView?

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
        } else {
            self.dataLabel!.text = ""
        }
    }


}

