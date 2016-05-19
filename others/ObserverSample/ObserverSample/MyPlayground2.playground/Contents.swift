//: Playground - noun: a place where people can play

import UIKit

protocol Observer : AnyObject {
    func update(value: AnyObject)
}

protocol Observable : AnyObject {
    func attach(obj: Observer)
    func detach(obj: Observer)
    func notify()
}

struct ObservableStruct<T> {
    
    var observers: Array<Observer> = []
    var dataStore: T?
    
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

var x = ObservableStruct<String>(value:"should")
print(x)


