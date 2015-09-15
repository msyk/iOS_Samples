//
//  ViewController.swift
//  CoreDataSample_Swift
//
//  Created by Masayuki Nii on 2015/07/13.
//  Copyright (c) 2015年 Masayuki Nii. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var data: [AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.data = appDelegate.localDB.allData()
        if (self.data == nil || self.data?.count < 1)   {
            appDelegate.localDB.getFromServer({
                self.data = appDelegate.localDB.allData()
                self.tableView.reloadData()
            })
        }
        if let d = self.data {
            for obj in d {
                let p = obj as! Person;
                print("Name: \(p.name), Yomi: \(p.yomi)");
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let d = data {
            return d.count;
        }
        return 0;
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("CELL",
                forIndexPath: indexPath) as UITableViewCell
            if let theLabel = cell.textLabel, d = data {
                let person = d[indexPath.row] as! Person
                
                theLabel.text = person.name
            }
            return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

