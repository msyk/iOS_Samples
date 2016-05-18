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

class ObservableStore {
    static var observables: Dictionary<Int, Array<Observable>> = [:]

    static func observableArray(index: Int) -> Array<Observable> {
        if (observables[index] == nil)    {
            observables[index] = []
        }
        return observables[index]!
    }
    
    static func setObservable(index: Int, asArray ar: Array<Observable>) {
        observables[index] = ar
    }
}

extension String {
    func attach(obj: Observable, inGroupID gid: Int)    {
        var observables = ObservableStore.observableArray(gid)
        observables.append(obj)
        ObservableStore.setObservable(gid, asArray: observables)
    }
    
    func detach(obj: Observable, inGroupID gid: Int)    {
        var observables = ObservableStore.observableArray(gid)
        var index = observables.startIndex
        for elem in observables {
            if elem === obj {
                observables.removeAtIndex(index)
            }
            index += 1
        }
        ObservableStore.setObservable(gid, asArray: observables)
    }
    
    func notify(gid: Int)    {
        let observables = ObservableStore.observableArray(gid)
        for elem in observables    {
            elem.update(self)
        }
    }
    
    // This is not called.
    func didSet() {
        print("didSet!!!!!")
    }
    
    // This is not called.
    func set(value: NSString) {
        print("didSet!!!!!")
    }
}
