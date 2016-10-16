//
//  ObservableData.swift
//  ObserverSample
//
//  Created by Masayuki Nii on 2016/05/13.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

/*************************************************
 * This class doesn't work well. Why? You think! *
 *************************************************/

import UIKit

class ObserverStore {
    static var observers: Dictionary<Int, Array<Observer>> = [:]

    static func observerArray(_ index: Int) -> Array<Observer> {
        if (self.observers[index] == nil)    {
            self.observers[index] = []
        }
        return self.observers[index]!
    }
    
    static func setObservers(_ index: Int, asArray ar: Array<Observer>) {
        self.observers[index] = ar
    }
}

extension String {
    func attach(_ obj: Observer, inGroupID gid: Int)    {
        var observersArray = ObserverStore.observerArray(gid)
        observersArray.append(obj)
        ObserverStore.setObservers(gid, asArray: observersArray)
    }
    
    func detach(_ obj: Observer, inGroupID gid: Int)    {
        var observersArray = ObserverStore.observerArray(gid)
        var index = observersArray.startIndex
        for elem in observersArray {
            if elem === obj {
                observersArray.remove(at: index)
            }
            index += 1
        }
        ObserverStore.setObservers(gid, asArray: observersArray)
    }
    
    func notify(_ gid: Int)    {
        let observersArray = ObserverStore.observerArray(gid)
        for elem in observersArray    {
            elem.update(self as AnyObject)
        }
    }
    
    // This is not called.
    func didSet() {
        print("didSet!!!!!")
    }
    
    // This is not called.
    func set(_ value: NSString) {
        print("didSet!!!!!")
    }
}
