//
//  RootViewController.swift
//  2_1_SplitVC
//
//  Created by 新居雅行 on 2014/07/18.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UISplitViewControllerDelegate {
    
    weak var containingVC: UIViewController? = nil
    
    override func viewDidLoad()
    {
        debugLogging()
        
        self.viewDidLoad()
        
        let storyboard = self.storyboard
        let svc = storyboard?.instantiateViewControllerWithIdentifier("svc")
            as UISplitViewController
        self.containingVC = svc
        
        self.addChildViewController(svc);
        svc.didMoveToParentViewController(self)
        self.view.addSubview(svc.view);
        
        let masterNC = svc.viewControllers[0] as UINavigationController
        let detailNC = svc.viewControllers[1] as UINavigationController
        svc.delegate = self
        
//        detailNC.topViewController.navigationItem.leftBarButtonItem = svc.displayModeButtonItem()
        
        let controller = masterNC.topViewController as MasterViewController
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        controller.managedObjectContext = appDelegate.managedObjectContext
        
        let hClass = self.traitCollection.horizontalSizeClass.toRaw()
        let vClass = self.traitCollection.verticalSizeClass.toRaw()
        println("Size Class: h:\(hClass) v:\(vClass) ex:1=Compact,2=Regular")
    }
    
    func setTraitCollection(traits: UITraitCollection?)
    {
        debugLogging()
        
        self.setOverrideTraitCollection(traits,
            forChildViewController: self.containingVC!)
        self.containingVC?.didMoveToParentViewController(self)
    }
    
    override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator
        coordinator: UIViewControllerTransitionCoordinator)
    {
        debugLogging(info: "size=\(NSStringFromCGSize(size))")

        if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            if (size.width > size.height)  {
                self.setTraitCollection(
                    UITraitCollection(horizontalSizeClass: .Regular))
            } else {
                self.setTraitCollection(nil)
            }
        }
    }
 
    func splitViewController(splitViewController: UISplitViewController,
        collapseSecondaryViewController secondaryViewController:UIViewController!,
        ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
            
            debugLogging()
            
            return true
    }
    
//    override func collapseSecondaryViewController(
//        secondaryViewController: UIViewController,
//        forSplitViewController splitViewController: UISplitViewController)
//    {
//        debugLogging()
//        
//    }
//    
//    override func separateSecondaryViewControllerForSplitViewController(
//        splitViewController: UISplitViewController) -> UIViewController
//    {
//        debugLogging()
//        
//        let detailNC = splitViewController.viewControllers[1] as UINavigationController
//        return detailNC.topViewController as DetailViewController
//    }

}

func debugLogging(
    info: String = "",
    function: String = __FUNCTION__,
    file: String = __FILE__,
    line: Int = __LINE__) {
    #if DEBUG
        let flag: NSCalendarUnit
            = .CalendarUnitHour       | .CalendarUnitMinute |
              .CalendarUnitNanosecond | .CalendarUnitSecond
        let components = NSCalendar.currentCalendar().components(flag, fromDate: NSDate())
        let misecond = Int(components.nanosecond / 1000000)
        let timeDesc = "\(components.hour):\(components.minute):\(components.second).\(misecond)"
        let fileName = file.lastPathComponent.stringByDeletingPathExtension
        let sourceInfo = "\(fileName).\(function)-line\(line)"
        println("\(timeDesc)[\(sourceInfo)]\(info)")
    #endif
}
