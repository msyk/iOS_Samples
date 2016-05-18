//
//  AppData.swift
//  ObserverSample
//
//  Created by Masayuki Nii on 2016/05/11.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

import UIKit

protocol Observable : AnyObject {
    func update(value: AnyObject)
}

protocol Observer : AnyObject {
    func attach(obj: Observable)
    func detach(obj: Observable)
    func notify()
}

class AppData : Observer {

    typealias DataType = String

    private var sharedString = ""
    
    var data: String = "" {
        didSet    {
            self.notify()
        }
    }
    
    private var obserbables: Array<Observable> = []
    
    func attach(obj: Observable)    {
        self.obserbables.append(obj)
    }
    
    // The detach method is not tested anymore. Sorry!
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
            elem.update(self.data)
        }
    }
    
}
