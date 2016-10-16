//
//  CalcOnThread.swift
//  MultiProcess
//
//  Created by Masayuki Nii on 2016/10/10.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

import UIKit

class CalcOnThread {
    
    static var number = 0;
    
    func startCalc(_ times: Int) -> Void {
        print("startCalc: Thread=\(Thread.current)")
        for _ in 1...times {
            CalcOnThread.number += 1;
        }
    }
    
    func startCalcOnThread(_ times: Int) -> Void {
        Thread.detachNewThread {
            print("startCalc: Thread=\(Thread.current)")
            for _ in 1...times {
                CalcOnThread.number += 1;
            }
        }
    }
    
    var queue = OperationQueue()
    
    func startCalcAsQueue(_ times: Int) -> Void {
        self.queue.addOperation {
            print("startCalc: Thread=\(Thread.current)")
            for _ in 1...times {
                CalcOnThread.number += 1;
            }
        }
    }
    
    func createCalcOperation(_ times: Int) -> Operation {
        let op = BlockOperation(block: {
            print("startCalc: Thread=\(Thread.current)")
            for _ in 1...times {
                CalcOnThread.number += 1;
            }
        })
        return op;
    }
    
    static let lock = NSLock()
    
    func createCalcOperationWithLock(_ times: Int) -> Operation {
        let op = BlockOperation(block: {
            print("startCalc: Thread=\(Thread.current)")
            for _ in 1...times {
                //CalcOnThread.lock.lock()
                objc_sync_enter(CalcOnThread.lock)
                CalcOnThread.number += 1;
                //CalcOnThread.lock.unlock()
                objc_sync_exit(CalcOnThread.lock)
                
            }
        })
        return op;
    }
    
    func downloadFileOperation() -> Operation {
        return BlockOperation(block: {
            print("[\(Date())]Download Starts: Thread=\(Thread.current)")
            
            let s = URLSession(configuration: URLSessionConfiguration.ephemeral)
            if let url = URL(string:"https://server.msyk.net/10m.txt") {
                let t = s.dataTask(with: url, completionHandler:
                    {(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void in
                        print("[\(Date())]Download Finished: Size=\(data?.count) Thread=\(Thread.current)")
                })
                t.resume()
            }
        })
    }
    
}
