//
//  LocalDB.swift
//  CoreDataSample_Swift
//
//  Created by Masayuki Nii on 2015/07/13.
//  Copyright (c) 2015年 Masayuki Nii. All rights reserved.
//

import UIKit
import CoreData

class LocalDB: NSObject {
    
    lazy var model: NSManagedObjectModel? = {
        let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")
        guard let url = modelURL else { return nil }
        return NSManagedObjectModel(contentsOfURL: url)
        }()
    
    lazy var moContext: NSManagedObjectContext? = {
        let moc = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        guard let model = self.model else { return nil }
        let pStoreCoordinator: NSPersistentStoreCoordinator?
        = NSPersistentStoreCoordinator(managedObjectModel: model);
        guard let coordinator = pStoreCoordinator else { return nil }
        do {
            moc.persistentStoreCoordinator = coordinator;
            let storeURL = self.documentURL.URLByAppendingPathComponent("localdb.sqlite");
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType,
                configuration: nil, URL: storeURL, options: nil)
            return moc
        } catch let error1 as NSError? {
            print(error1?.description);
        }
        return nil
        }()
    
    lazy var entityDescPeople: NSEntityDescription? = {
        return NSEntityDescription.entityForName("Person",
            inManagedObjectContext: self.moContext!)
        }()
    
    lazy var documentURL: NSURL = {
        let fm: NSFileManager = NSFileManager.defaultManager();
        let storeURLs = fm.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory,
            inDomains: NSSearchPathDomainMask.UserDomainMask);
        return storeURLs[0] as NSURL;
        }()
    
    func getFromServer(doItAfter: ()->Void)    {
        let urlToAccess = NSURL(string: "https://server.msyk.net/apitest/index.php?op=R")
        guard let url = urlToAccess else { return }
        let request = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration();
        let session = NSURLSession(configuration: config);
        let task = session.dataTaskWithRequest(request,
            completionHandler:{
                (data: NSData?, res: NSURLResponse?, er: NSError?) -> Void in
                guard let dataDL = data else { return }
                let dataArray: AnyObject
                do {
                    dataArray = try NSJSONSerialization.JSONObjectWithData(dataDL,
                        options: NSJSONReadingOptions.MutableContainers)
                } catch _ {
                    return
                }
                for currentRecord in dataArray as! Array<AnyObject> {
                    let aPerson = Person(
                        entity: self.entityDescPeople!,
                        insertIntoManagedObjectContext: self.moContext)
                    aPerson.name = currentRecord["name"] as? String
                    aPerson.yomi = currentRecord["yomi"] as? String
                    aPerson.tel = currentRecord["tel"] as? String
                    aPerson.cellphone = currentRecord["cellphone"] as? String
                }
                do {
                    try self.moContext?.save()
                    NSOperationQueue.mainQueue().addOperationWithBlock(doItAfter)
                } catch let error1 as NSError? {
                    print(error1?.description);
                    return;
                }
            }
        )
        task.resume()
    }
    
    func allData() -> [AnyObject]?    {
        do {
            let request = NSFetchRequest(entityName: "Person");
            let sortDescriptor = NSSortDescriptor(key: "yomi", ascending: false)
            request.sortDescriptors = [sortDescriptor]
            let result = try self.moContext?.executeFetchRequest(request)
            return result
        } catch let error1 as NSError? {
            print(error1?.description);
            return nil;
        }
    }
    
}
