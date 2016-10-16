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

class ObserverPool    {
    
    static var observers = Array<AnyObject>()
    static var observerPool = Dictionary<Int, Array<Observer>>()
    
    static func observerArray(_ obj: AnyObject) -> Array<Observer>  {
        
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
        
        if (observerPool[index] == nil)  {
            self.observerPool.updateValue([], forKey: index)
        }
        return observerPool[index]!
    }
}

extension NSString {
    
    func attach(_ obj: Observer)    {
         var ob = ObserverPool.observerArray(self)
        ob.append(obj)
    }
    
    func dettach(_ obj: Observer)    {
        var ob = ObserverPool.observerArray(self)
        var index = ob.startIndex
        for elem in ob {
            if elem === obj {
                ob.remove(at: index)
            }
            index += 1
        }
    }
    
    func notify()    {
        let ob = ObserverPool.observerArray(self)
        for elem in ob    {
            elem.update(self as AnyObject)
        }
    }
    
    func didSet() -> Void    {
        self.notify()
    }
}
