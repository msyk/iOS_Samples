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
    
    var obserbables: Array<Observable> { get set }
    var dataStore: DataType { get set }
}

extension ObservableData {
    mutating func attach(obj: Observable)    {
        self.obserbables.append(obj)
    }
    
    mutating func detach(obj: Observable)    {
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
}

class AppDataImp : ObservableData {
    
    typealias DataType = String

    var obserbables: Array<Observable> = []
    var dataStore: String = ""
    
    var data: String {
        get    {
            return self.dataStore
        }
        set(value)    {
            self.dataStore = value
            self.notify()
        }
    }
}
