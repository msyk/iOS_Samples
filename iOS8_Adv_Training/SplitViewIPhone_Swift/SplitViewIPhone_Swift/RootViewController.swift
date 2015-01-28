//
//  RootViewController.swift
//  SplitViewIPhone_Swift
//
//  Created by 新居雅行 on 2015/01/28.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UISplitViewControllerDelegate {
    
    private var containingVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let svc = storyboard?.instantiateViewControllerWithIdentifier("SPLITVIEW") as UIViewController? {
            containingVC = svc
            self.addChildViewController(svc)
            svc.didMoveToParentViewController(self)
            view.addSubview(svc.view)
            (svc as UISplitViewController).delegate = self
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            
            if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
                if let splitVC = containingVC  {
                    if size.width > size.height {
                        let tc = UITraitCollection(horizontalSizeClass: .Regular)
                        self.setOverrideTraitCollection(tc, forChildViewController: splitVC)
                    } else {
                        self.setOverrideTraitCollection(nil, forChildViewController: splitVC)
                    }
                    splitVC.didMoveToParentViewController(self)
                }
            }
    }
    
    func splitViewController(splitViewController: UISplitViewController,
        collapseSecondaryViewController secondaryViewController: UIViewController!,
        ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        return true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
