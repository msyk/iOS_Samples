//
//  MultiProcessTests.swift
//  MultiProcessTests
//
//  Created by Masayuki Nii on 2016/10/10.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

import XCTest
@testable import MultiProcess

class MultiProcessTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleCounter() {
        print("testSimpleCounter: Thread=\(Thread.current)")

        let c = CalcOnThread()
        CalcOnThread.number = 0
        c.startCalc(10000)
        XCTAssert(CalcOnThread.number == 10000, "OMG you can't add numbers? really?")
        
        let c1 = CalcOnThread()
        let c2 = CalcOnThread()
        let c3 = CalcOnThread()
        CalcOnThread.number = 0
        c1.startCalc(1000)
        c2.startCalc(1000)
        c3.startCalc(1000)
        XCTAssert(CalcOnThread.number == 3000, "OMG you can't add numbers? really?")
       /*
        CalcOnThread.number = 0
        c1.startCalcOnThread(1000)
        c2.startCalcOnThread(1000)
        c3.startCalcOnThread(1000)
        print(">>> CalcOnThread.number = \(CalcOnThread.number)")
        XCTAssert(CalcOnThread.number == 3000, "OMG you can't add numbers? really?")
        // 終わるのを待てない？　dispatch_group_notifyがあるが…
        */
        let queuedC = CalcOnThread()
        CalcOnThread.number = 0
        queuedC.queue.addOperations(
            [queuedC.createCalcOperation(10000),
             queuedC.createCalcOperation(10000),
             queuedC.createCalcOperation(10000)],
            waitUntilFinished: true)
        print(">>> CalcOnThread.number = \(CalcOnThread.number)")
        XCTAssert(CalcOnThread.number == 30000, "OMG you can't add numbers? really?")
        
        let qC2 = CalcOnThread()
        CalcOnThread.number = 0
        qC2.queue.addOperations(
            [qC2.createCalcOperationWithLock(10000),
             qC2.createCalcOperationWithLock(10000),
             qC2.createCalcOperationWithLock(10000)],
            waitUntilFinished: true)
        print(">>> CalcOnThread.number = \(CalcOnThread.number)")
        XCTAssert(CalcOnThread.number == 30000, "OMG you can't add numbers? really?")
        
        // see defer http://qiita.com/codelynx/items/0ecd28c8a7da0a0e42b5
        
        //qC2.downloadFile()
    }

    func testMultipleCounter1() {
        self.measure {
            let queuedC = CalcOnThread()
            CalcOnThread.number = 0
            queuedC.queue.addOperations(
                [queuedC.createCalcOperation(100000),
                 queuedC.createCalcOperation(100000),
                 queuedC.createCalcOperation(100000)],
                waitUntilFinished: true)
            print(">>> CalcOnThread.number = \(CalcOnThread.number)")
        }
    }
    func testMultipleCounter2() {
        self.measure {
            let qC2 = CalcOnThread()
            CalcOnThread.number = 0
            qC2.queue.addOperations(
                [qC2.createCalcOperationWithLock(100000),
                 qC2.createCalcOperationWithLock(100000),
                 qC2.createCalcOperationWithLock(100000)],
                waitUntilFinished: true)
            print(">>> CalcOnThread.number = \(CalcOnThread.number)")
    }
    }
    
    func testAsyncAndAsync()    {
        let qC2 = CalcOnThread()
        qC2.queue.addOperations(
            [qC2.downloadFileOperation(),
             qC2.downloadFileOperation(),
             qC2.downloadFileOperation()],
            waitUntilFinished: true)
        print(">>> Download Tasks finished")
}

}
