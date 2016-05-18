//
//  AppData4.swift
//  ObserverSample
//
//  Created by Masayuki Nii on 2016/05/14.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

import UIKit

class ObservableStruct<T> {
    
    var obserbables: Array<Observable> = []
    var dataStore: T?
    
    func attach(obj: Observable)    {
        self.obserbables.append(obj)
    }
    
    func detach(obj: Observable)    {
        var index = self.obserbables.startIndex
        for elem in self.obserbables {
            if elem === obj {
                self.obserbables.removeAtIndex(index)
            }
            index += 1
        }
    }
    
    func notify()    {
        for elem in self.obserbables    {
            elem.update(self.dataStore as! AnyObject)
        }
    }
    
    var data: T {
        get    {
            return self.dataStore!
        }
        set(value)    {
            self.dataStore = value
            self.notify()
        }
    }
}

class AppDataWrap : ObservableStruct<String> {

}
