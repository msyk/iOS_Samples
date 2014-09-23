//
//  MasterViewController.swift
//  MasterDetail
//
//  Created by 新居雅行 on 2014/09/21.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = NSMutableArray()


    override func awakeFromNib() {
        debugLogging()
        
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        debugLogging()

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate.date(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        debugLogging()

        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as NSDate
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = objects[indexPath.row] as NSDate
        cell.textLabel?.text = object.description
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        debugLogging()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        debugLogging()
        return indexPath
    }
    
    override func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        debugLogging()
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        debugLogging()

    }

    // MARK: - CHECKING
    
    //===================================================================
    
    required init(coder aDecoder: NSCoder) {
        debugLogging()
        
        return super.init(coder: aDecoder);
    }
    
    override func viewDidAppear(animated: Bool) {
        debugLogging()
        
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        debugLogging()
        
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        debugLogging()
        
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        debugLogging()
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        debugLogging()
        
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        debugLogging()
        
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            debugLogging()
            
            super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func willTransitionToTraitCollection(
        newCollection: UITraitCollection,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            debugLogging()
            
            super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection) {
        debugLogging()
        
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func updateViewConstraints() {
        debugLogging()
        
        super.updateViewConstraints()
    }
    

}

