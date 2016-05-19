//
//  AppData4.swift
//  ObserverSample
//
//  Created by Masayuki Nii on 2016/05/14.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

import UIKit

class ObservableStruct<T> {
    
    var observers: Array<Observer> = []
    var dataStore: T?
    
    func attach(obj: Observer)    {
        self.observers.append(obj)
    }
    
    func detach(obj: Observer)    {
        var index = self.observers.startIndex
        for elem in self.observers {
            if elem === obj {
                self.observers.removeAtIndex(index)
            }
            index += 1
        }
    }
    
    func notify()    {
        for elem in self.observers    {
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
    
    init()  {
        self.dataStore = nil
    }
    
    init(value: T)  {
        self.dataStore = value
    }
    
}

class AppDataWrap : ObservableStruct<String> {
    
}
