//
//  DownloadOperation.swift
//  MultiProcess
//
//  Created by Masayuki Nii on 2016/11/01.
//  Copyright © 2016年 Masayuki Nii. All rights reserved.
//

import UIKit

class DownloadOperation: Operation, URLSessionDataDelegate {
    
    private let keyExecuting = "isExecuting"
    private let keyFinished = "isFinished"
    private var _executing: Bool
    private var _finished: Bool
    private var urlString: String = ""
    
    override var isAsynchronous: Bool{
        get {
            return true
        }
    }
    
    override var isExecuting: Bool {
        get {
            return self._executing
        }
        set(value) {
            self._executing = value
        }
    }
    
    override var isFinished: Bool {
        get {
            return self._finished
        }
        set(value) {
            self._finished = value
        }
    }
    
    override init() {
        self._executing = false
        self._finished = false
        super.init()
    }
    
    convenience init(URLString urlStr : String) {
        self.init()
        self.urlString = urlStr
    }
    
    override func start() {
        print("[\(Date())]start: Thread=\(Thread.current)")
        if (self.isFinished)    {
            self.willChangeValue(forKey: self.keyFinished)
            self._finished = true
            self.didChangeValue(forKey: self.keyFinished)
        }
        self.willChangeValue(forKey: self.keyExecuting)
        self._executing = true
        self.didChangeValue(forKey: self.keyExecuting)
        
        self.main()
    }
    
    override func main() {
        downloadLargeFile()
    }
    
    func finishMyOperation()    {
        print("[\(Date())]finishMyOperation: Thread=\(Thread.current)")
        self.willChangeValue(forKey: self.keyExecuting)
        self.willChangeValue(forKey: self.keyFinished)
        self._executing = false
        self._finished = true
        self.didChangeValue(forKey: self.keyExecuting)
        self.didChangeValue(forKey: self.keyFinished)
    }
    
    private var data = Data()
    private var queue = OperationQueue()
    
    func downloadLargeFile() {
        print("[\(Date())]downloadLargeFile: Thread=\(Thread.current)")
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral,
                                 delegate: self,
                                 delegateQueue: self.queue)
        if let url = URL(string: self.urlString) {
            let task = session.dataTask(with: url)
            task.resume()
        }
    }
    
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        print("[\(Date())]didReceive: Size=\(data.count) Cancel=\(self.isCancelled) Thread=\(Thread.current)")
        self.data.append(data);
        if(self.isCancelled)    {
            session.invalidateAndCancel()
            finishMyOperation()
        }
    }
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        print("[\(Date())]didCompleteWithError: error=\(error)")
        print("[\(Date())]Download Finished: Size=\(self.data.count) Thread=\(Thread.current)")
        finishMyOperation()
    }
}
