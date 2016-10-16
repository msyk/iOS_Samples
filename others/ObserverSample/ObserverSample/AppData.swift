//
//  AppData.swift
//  ObserverSample
//
//  Created by Masayuki Nii on 2016/05/11.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

import UIKit

protocol Observer : AnyObject {
    func update(_ value: AnyObject)
}

protocol Observable : AnyObject {
    func attach(_ obj: Observer)
    func detach(_ obj: Observer)
    func notify()
}

class AppData : Observable {

    fileprivate var sharedString = ""
    
    var data: String = "" {
        didSet    {
            self.notify()
        }
    }
    
    fileprivate var observers: Array<Observer> = []
    
    func attach(_ obj: Observer)    {
        self.observers.append(obj)
    }
    
    // The detach method is not tested anymore. Sorry!
    func detach(_ obj: Observer)    {
        var index = self.observers.startIndex
        for elem in self.observers {
            if elem === obj {
                self.observers.remove(at: index)
            }
            index += 1
        }
    }
    
    func notify()    {
        for elem in self.observers    {
            elem.update(self.data as AnyObject)
        }
    }
    
}
