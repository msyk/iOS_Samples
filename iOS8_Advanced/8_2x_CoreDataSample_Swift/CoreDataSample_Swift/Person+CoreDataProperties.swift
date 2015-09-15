//
//  Person+CoreDataProperties.swift
//  CoreDataSample_Swift
//
//  Created by Masayuki Nii on 2015/09/15.
//  Copyright © 2015年 Masayuki Nii. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Person {

    @NSManaged var cellphone: String?
    @NSManaged var name: String?
    @NSManaged var tel: String?
    @NSManaged var yomi: String?

}
