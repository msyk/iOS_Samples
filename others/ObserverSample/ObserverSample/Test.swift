//
//  Test.swift
//  ObserverSample
//
//  Created by Masayuki Nii on 2016/05/13.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

/*************************************************
 * This class doesn't work well. Why? You think! *
 *************************************************/

import UIKit
/*
class ObservablePool    {
    
    static var observers = Array<AnyObject>()
    static var observablesPool = Dictionary<Int, Array<Observable>>()
    
    static func observableArray(obj: AnyObject) -> Array<Observable>  {
        
        print(observers.startIndex, observers.endIndex, obj)
        
        var index = observers.startIndex
        for elem in observers {
            if elem === obj {
                break
            }
            index += 1
        }
        if (observers.count == 0 || index >= observers.endIndex) {
            observers.append(obj)
            index = observers.endIndex
        }
        
        if (observablesPool[index] == nil)  {
            self.observablesPool.updateValue([], forKey: index)
        }
        return observablesPool[index]!
    }
}

extension NSString {
    
    func attach(obj: Observable)    {
         var ob = ObservablePool.observableArray(self)
        ob.append(obj)
    }
    
    func dettach(obj: Observable)    {
        var ob = ObservablePool.observableArray(self)
        var index = ob.startIndex
        for elem in ob {
            if elem === obj {
                ob.removeAtIndex(index)
            }
            index += 1
        }
    }
    
    func notify()    {
        let ob = ObservablePool.observableArray(self)
        for elem in ob    {
            elem.update(self as AnyObject)
        }
    }
    
    func didSet() -> Void    {
        self.notify()
    }
}
*/