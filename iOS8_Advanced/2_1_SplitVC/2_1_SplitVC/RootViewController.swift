//
//  RootViewController.swift
//  2_1_SplitVC
//
//  Created by 新居雅行 on 2014/07/18.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    weak var containingVC: UIViewController? = nil
    
    override func viewDidLoad()
    {
        let storyboard = self.storyboard as UIStoryboard
        let svc = storyboard.instantiateViewControllerWithIdentifier("svc")
            as UISplitViewController
        self.containingVC = svc
        
        self.addChildViewController(svc);
        self.view.addSubview(svc.view);
        
        let masterNC = svc.viewControllers[0] as UINavigationController
        let detailNC = svc.viewControllers[1] as UINavigationController
        svc.delegate = detailNC.topViewController as DetailViewController
        //svc.preferredDisplayMode = .AllVisible
        
//        if (UIDevice.currentDevice().userInterfaceIdiom != .Phone) {
//            self.setTraitCollection(
//                UITraitCollection(horizontalSizeClass: .Regular))
//        }
    }
    
    func setTraitCollection(traits: UITraitCollection?)
    {
        self.setOverrideTraitCollection(traits,
            forChildViewController: self.containingVC)
        self.containingVC?.didMoveToParentViewController(self)
    }
    
    override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator
            coordinator: UIViewControllerTransitionCoordinator!)
    {
        println(__FUNCTION__, __LINE__, NSStringFromCGSize(size))
        if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            if (size.width > size.height)  {
                self.setTraitCollection(
                    UITraitCollection(horizontalSizeClass: .Regular))
            } else {
                self.setTraitCollection(nil)
            }
        }
    }
    
}
