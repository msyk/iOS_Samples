//
//  SelfInBlock.swift
//  1_2_SelfInBlock
//
//  Created by 新居雅行 on 2014/07/11.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class SelfInBlock: NSObject {
    
    private var str: String = ""
    
    lazy
    private var block: () -> Void = {
        //        [unowned self]
        //        () -> Void in
        //        self.doSomething()
        //        self.str = "Test"
        //        let x = self.str
    }
    
    func configureBlock() {
        //        self.block = {
        //            [unowned self] () -> Void in
        //            self.doSomething()
        //            self.str = "Test"
        //            let x = self.str
        //        }
        //        let q: () -> Void = {
        //            [unowned self] () -> Void in
        //            self.doSomething()
        //            self.str = "Test"
        //            let x = self.str
        //        }
        //        self.block = q;
        self.block()
    }
    
    public func doSomething()
    {
        NSLog("Did something");
    }
    
    func trial()   {
        var c1 : (Int, Int, String) -> String
        c1 = {
            (Int x, Int y, String z) -> String in
            return("\(x)-\(y) \(z)")
        }
        println("result = " + c1(1, 2, "Integer"))
        
        var c2 : (Int, Int, String) -> String
        c2 = {
            (x, y, z) -> String in
            return("\(x)-\(y) \(z)")
        }
        println("result = " + c1(3, 4, "Integer"))
        
        c2 = {
            x, y, z in
            return("\(x)-\(y) \(z)")
        }
        println("result = " + c1(5, 6, "Integer"))
        
        //        c2 = {    // Error
        //            return("\(x)-\(y) \(z)")
        //        }
        //        println("result = " + c1(3, 4, "Integer"))
        
        var c3 : (Void) -> Void
        c3 = {
            (Void) -> Void in
            println("test3")
        }
        c3()
        
        var c4 : (Void) -> Void
        c4 = {
            () -> Void in
            println("test4-1")
        }
        c4()
        
        c4 = {
            println("test4-2")
        }
        c4()
        
        var c5 : () -> String
        c5 = {
            () -> String in
            return("test5-1")
        }
        println(c5())
        
        c5 = {
            return("test5-2")
        }
        println(c5())
        
        var c6 : (Int) -> String
        c6 = {
            (n) -> String in
            return("test6-1=\(n)")
        }
        println(c6(34))
        c6 = {
            n in
            return("test6-1=\(n)")
        }
        println(c6(11))
        
        //        c6 = {
        //            return("test6-1=\(n)")
        //        }
        //        println(c6(67))
        
    }
}
