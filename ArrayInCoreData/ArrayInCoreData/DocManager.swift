//
//  DocManager.swift
//  ArrayInCoreData
//
//  Created by IAPPS on 15/2/21.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ArrayInCoreData")
        container.loadPersistentStores(completionHandler: {(storeDescription, err) in if let err = err {
            fatalError("Loading of store failed: \(err)")
        }})
        return container
    }()
    
    static func fetchProjects() -> [ItemsInfo] {
        
        let fetchRequest = NSFetchRequest<ItemsInfo>(entityName: "ItemsInfo")
        fetchRequest.sortDescriptors = [NSSortDescriptor (key: "date", ascending: false)]
        let context = DELEGATE.persistentContainer.viewContext
        do{
            let myProjects = try context.fetch(fetchRequest)
            return myProjects
        } catch let fetchErr{
            print("Failed to fetch companiess: ", fetchErr)
            return []
        }
    }
}
