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
    
    // Demo 1-1 Just Repeating
    func testDemo1_1() {
        print(">>> Current Thread = \(Thread.current)")
        print("testSimpleCounter: Thread=\(Thread.current)")
        let c = CalcOnThread()
        CalcOnThread.number = 0
        c.startCalc(10000)
        XCTAssert(CalcOnThread.number == 10000, "OMG you can't add numbers? really?")
    }
    
    // Demo 1-2 Just Repeating and Repeat it
    func testDemo1_2() {
        print(">>> Current Thread = \(Thread.current)")
        let repeating = 1000
        let c1 = CalcOnThread()
        let c2 = CalcOnThread()
        let c3 = CalcOnThread()
        CalcOnThread.number = 0
        c1.startCalc(repeating)
        c2.startCalc(repeating)
        c3.startCalc(repeating)
        XCTAssert(CalcOnThread.number == 3 * repeating, "OMG you can't add numbers? really?")
    }
    
    // Demo 1-3 Repeating on another thread
    func testDemo1_3() {
        print(">>> Current Thread = \(Thread.current)")
        let repeating = 1000
        let c = CalcOnThread()
        CalcOnThread.number = 0
        c.startCalcOnThread(repeating)
        print(">>> CalcOnThread.number = \(CalcOnThread.number)")
        XCTAssert(CalcOnThread.number == repeating, "OMG you can't add numbers? really?")
    }
    
    // Demo 1-4 Repeating on other threads
    func testDemo1_4() {
        print(">>> Current Thread = \(Thread.current)")
        let repeating = 1000
        let c1 = CalcOnThread()
        let c2 = CalcOnThread()
        let c3 = CalcOnThread()
        CalcOnThread.number = 0
        c1.startCalcOnThread(repeating)
        c2.startCalcOnThread(repeating)
        c3.startCalcOnThread(repeating)
        print(">>> CalcOnThread.number = \(CalcOnThread.number)")
        XCTAssert(CalcOnThread.number == 3*repeating, "OMG you can't add numbers? really?")
        // Assert happens before finishing threads.
        // The dispatch_group_notify function is one of the solution.
    }
    
    // Demo 1-5 Operation works as like thread
    func testDemo1_5() {
        print(">>> Current Thread = \(Thread.current)")
        let repeating = 10000
        let queuedC = CalcOnThread()
        CalcOnThread.number = 0
        queuedC.queue.addOperations(
            [queuedC.createCalcOperation(repeating),
             queuedC.createCalcOperation(repeating),
             queuedC.createCalcOperation(repeating)],
            waitUntilFinished: true)
        print(">>> CalcOnThread.number = \(CalcOnThread.number)")
        XCTAssert(CalcOnThread.number == 3 * repeating, "OMG you can't add numbers? really?")
    }
    
    // Demo 1-6 Operation with lock
    func testDemo1_6() {
        print(">>> Current Thread = \(Thread.current)")
        let repeating = 10000
        let qC2 = CalcOnThread()
        CalcOnThread.number = 0
        
        // This can't work because assert is going to execute before finishing threads
        //qC2.queue.addOperation(qC2.createCalcOperationWithLock(repeating))
        //qC2.queue.addOperation(qC2.createCalcOperationWithLock(repeating))
        //qC2.queue.addOperation(qC2.createCalcOperationWithLock(repeating))
        
        qC2.queue.addOperations(
            [qC2.createCalcOperationWithLock(repeating),
             qC2.createCalcOperationWithLock(repeating),
             qC2.createCalcOperationWithLock(repeating)],
            waitUntilFinished: true)
        
        print(">>> CalcOnThread.number = \(CalcOnThread.number)")
        XCTAssert(CalcOnThread.number == 3 * repeating, "OMG you can't add numbers? really?")
    }
    
    // Demo 1-7 Cost of Lock
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
    
    // Demo 1-8 Serialized Operations
    func testDemo1_8() {
        print(">>> Current Thread = \(Thread.current)")
        let repeating = 10000
        let qC2 = CalcOnThread()
        CalcOnThread.number = 0
        
        let op1 = qC2.createCalcOperationWithLock(repeating);
        let op2 = qC2.createCalcOperationWithLock(repeating);
        let op3 = qC2.createCalcOperationWithLock(repeating);
        op2.addDependency(op1)
        op3.addDependency(op2)
        qC2.queue.addOperation(op1)
        qC2.queue.addOperation(op2)
        qC2.queue.addOperation(op3)
        
        qC2.queue.waitUntilAllOperationsAreFinished()
        
        print(">>> CalcOnThread.number = \(CalcOnThread.number)")
        XCTAssert(CalcOnThread.number == 3 * repeating, "OMG you can't add numbers? really?")
    }
    
    // Demo 1-9 Set max concurrent thread number
    func testDemo1_9() {
        print(">>> Current Thread = \(Thread.current)")
        let repeating = 10000
        let qC2 = CalcOnThread()
        CalcOnThread.number = 0
        qC2.queue.maxConcurrentOperationCount = 1;
        qC2.queue.addOperations(
            [qC2.createCalcOperation(repeating),
             qC2.createCalcOperation(repeating),
             qC2.createCalcOperation(repeating)],
            waitUntilFinished: true)
        print(">>> CalcOnThread.number = \(CalcOnThread.number)")
        XCTAssert(CalcOnThread.number == 3 * repeating, "OMG you can't add numbers? really?")
    }
    
    // Demo 1-10
    
    func testDemo1_10()    {
        let qC2 = CalcOnThread()
        qC2.queue.maxConcurrentOperationCount = 1;
        qC2.queue.addOperations(
            [qC2.downloadFileOperation(),
             qC2.downloadFileOperation(),
             qC2.downloadFileOperation()],
            waitUntilFinished: true)
        print(">>> Download Tasks finished")
    }
    
    let url10M = "https://server.msyk.net/10m.txt"
    let url100M = "https://server.msyk.net/100m.txt"

    // Demo 1-11 Create Class inherited Operation
    
    func testDemo1_11()    {
        
        let qC2 = CalcOnThread()
        //qC2.queue.maxConcurrentOperationCount = 1;
        qC2.queue.addOperation(DownloadOperation(URLString: self.url100M))
        qC2.queue.addOperation(DownloadOperation(URLString: self.url100M))
        qC2.queue.addOperation(DownloadOperation(URLString: self.url100M))
        //sleep(1)
        //qC2.queue.cancelAllOperations()
        qC2.queue.waitUntilAllOperationsAreFinished()
        print(">>> Download Tasks finished")
    }
    
}
