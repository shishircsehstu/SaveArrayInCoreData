//
//  ItemsInfo+CoreDataProperties.swift
//  ArrayInCoreData
//
//  Created by IAPPS on 15/2/21.
//
//

import Foundation
import CoreData


extension ItemsInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemsInfo> {
        return NSFetchRequest<ItemsInfo>(entityName: "ItemsInfo")
    }

    @NSManaged public var values: Data?

}

extension ItemsInfo : Identifiable {

}
