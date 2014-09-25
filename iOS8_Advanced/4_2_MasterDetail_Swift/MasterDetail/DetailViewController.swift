//
//  DetailViewController.swift
//  MasterDetail
//
//  Created by 新居雅行 on 2014/09/21.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
    
    override func viewDidLoad() {
        debugLogging()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        self.navigationItem.leftBarButtonItem
            = self.splitViewController?.displayModeButtonItem()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    override func awakeFromNib() {
        debugLogging()
        
        super.updateViewConstraints()
    }
}

