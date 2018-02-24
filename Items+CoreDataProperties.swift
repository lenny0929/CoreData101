//
//  Items+CoreDataProperties.swift
//  CoreData_101
//
//  Created by Lenny on 2018/2/24.
//  Copyright © 2018年 Lenny. All rights reserved.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Int32

}
