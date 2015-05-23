//
//  ViewController.swift
//  2_1_ViewTest
//
//  Created by 新居雅行 on 2014/07/24.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction private func tapButton() {
        let vc : UIViewController = UIViewController()
        self.view.window?.rootViewController = vc;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
        
        let tc = self.traitCollection
        println(tc.horizontalSizeClass,
            tc.displayScale,
            tc.userInterfaceIdiom,
            tc.verticalSizeClass)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
    }
    
    // Try to comment out the method below
    override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            println((__FILE__ as String).lastPathComponent, __FUNCTION__)
    }
    
    
    override func willTransitionToTraitCollection(
        newCollection: (UITraitCollection!),
        withTransitionCoordinator coordinator: (UIViewControllerTransitionCoordinator!))
    {
            super.willTransitionToTraitCollection(
                newCollection, withTransitionCoordinator: coordinator)
            println((__FILE__ as String).lastPathComponent, __FUNCTION__)
            
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection!) {
        super.traitCollectionDidChange(previousTraitCollection)
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.updateViewConstraints()
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
        
    }

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration d: NSTimeInterval) {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: d)
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
        
    }

    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration d: NSTimeInterval) {
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        println((__FILE__ as String).lastPathComponent, __FUNCTION__)
    }
}

