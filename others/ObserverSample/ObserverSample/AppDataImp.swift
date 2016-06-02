//
//  ObservableData.swift
//  ObserverSample
//
//  Created by Masayuki Nii on 2016/05/13.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

import UIKit

protocol ObservableData {
    associatedtype DataType
    
    var observers: Array<Observer> { get set }
    var dataStore: DataType { get set }
}

extension ObservableData {
    mutating func attach(obj: Observer)    {
        self.observers.append(obj)
    }
    
    mutating func detach(obj: Observer)    {
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

    var data: DataType {
        get    {
            return self.dataStore
        }
        set(value)    {
            self.dataStore = value
            self.notify()
        }
    }
}

class AppDataImp : ObservableData {
    
    typealias DataType = String

    internal var observers: Array<Observer> = []
    internal var dataStore: String = ""

}
