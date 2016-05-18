//
//  MasterViewController.swift
//  ObserverSample
//
//  Created by Masayuki Nii on 2016/05/11.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, Observable {

    // [Demo 2][Demo 3][Demo 4] Demo 1 works leaving below line.
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet var textField: UITextField?

    @IBAction func typeing(sender: UITextField) {
        print(#file, #function)

        //[Demo 1]
//        let otherNC = self.splitViewController?.viewControllers[1] as! UINavigationController
//        let otherVC = otherNC.topViewController as! DetailViewController
//        otherVC.textField?.text = self.textField?.text

        // [Demo 2][Demo 3][Demo 4]
//        self.appDelegate.store.data = (self.textField?.text)!;

        // [Demo 5]
        self.appDelegate.store = (self.textField?.text)!;
        self.appDelegate.store.notify(10)

    }
    
    func update(value: AnyObject) {
        // [Demo 2][Demo 3][Demo 4][Demo 5]
        self.textField?.text = value as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // [Demo 2][Demo 3][Demo 4]
//        self.appDelegate.store.attach(self);
        
        // [Demo 5]
       self.appDelegate.store.attach(self, inGroupID:10);
 }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}

