//
//  SelfInBlock.swift
//  1_2_SelfInBlock
//
//  Created by 新居雅行 on 2014/07/11.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import UIKit

class SelfInBlock: NSObject {
    
//   @lazy 
    var block: () -> Void = {
//        [unowned self] () -> Void in
//        self.doSomething()
//        self.str = "Test"
//        let x = self.str
    }
    var str: String = ""
    
    func configureBlock() {
        self.block = {
            self.doSomething()
            self.str = "Test"
            let x = self.str
        }
//        let q: () -> Void = {[unowned self] () -> Void in
//            self.doSomething()
//            self.str = "Test"
//            let x = self.str
//        }
//        self.block = q;
        self.block()
    }
    
    func doSomething()
    {
        NSLog("Did something");
    }

    func trial()   {
        var c1 : (Int, Int, String) -> String
        c1 = {
            (Int x, Int y, String z) -> String in
            return("\(x)-\(y) \(z)")
        }
        println("result = " + c1(3, 4, "Integer"))
        
        var c2 : (Int, Int, String) -> String
        c2 = {
            (x, y, z) -> String in
            return("\(x)-\(y) \(z)")
        }
        println("result = " + c1(3, 4, "Integer"))
        
        c2 = {
            (x, y, z) in
            return("\(x)-\(y) \(z)")
        }
        println("result = " + c1(3, 4, "Integer"))
        
        var c3 : (Void) -> Void
        c3 = {
            (Void) -> Void in
            println("test3")
        }
        c3()
        
        var c4 : () -> Void
        c4 = {
            () -> Void in
            println("test4-1")
        }
        c4()
        
        c4 = {
            println("test4-2")
        }
        c4()
        
    }
}
