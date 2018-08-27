//
//  Entity+CoreDataProperties.swift
//  CoreDataSample
//
//  Created by 水野祥子 on 2018/08/27.
//  Copyright © 2018年 sachiko. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var title: String?
    @NSManaged public var discription: String?

}
