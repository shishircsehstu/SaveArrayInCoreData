//
//  ViewController.swift
//  ArrayInCoreData
//
//  Created by IAPPS on 15/2/21.
//

import UIKit
import CoreData

struct student: Codable{
    
    var name = String()
    var age = Int()
    var city = String()
}

class ViewController: UIViewController {
    
    let delegate = (UIApplication.shared.delegate as! AppDelegate)
    var allStudentInfo = [student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveValue()
        showValue()
        
    }
    
    func saveValue(){
        
        
        var stdInfo = student()
        stdInfo.name = "Putin"
        stdInfo.age = 50
        stdInfo.city = "Russia"
        allStudentInfo.append(stdInfo)
        
        stdInfo.name = "Erdogan"
        stdInfo.age = 55
        stdInfo.city = "Turkey"
        allStudentInfo.append(stdInfo)
        
        let projectsInfo = NSEntityDescription.insertNewObject(forEntityName: "ItemsInfo", into: delegate.persistentContainer.viewContext) as! ItemsInfo
        
        let audioArray:[String:[student]] = ["allStudentInfo": allStudentInfo]
        let jsonData = try! JSONEncoder().encode(audioArray)
        projectsInfo.values = jsonData
        delegate.saveContext()
        
        
    }
    
    func showValue(){
        
        let names = getValue()
        for i in 0..<names.count{
            let stdData = names[i].values
            let stdInfo = getStudentInfo(jsonData: stdData!)
            
            for singleStd in stdInfo{
                
                print(singleStd.name)
                print(singleStd.age)
                print(singleStd.city)
                print("=======")
            }
        }
    }
    
    func getStudentInfo(jsonData: Data) -> [student]{
        
        let result = try! JSONDecoder().decode([String: [student]].self, from: jsonData)
        let allStd = result["allStudentInfo"]!
        return allStd
        
    }

    func getValue()->[ItemsInfo]{
        
        let fetchRequest = NSFetchRequest<ItemsInfo>(entityName: "ItemsInfo")
        let context = delegate.persistentContainer.viewContext
        do{
            let names = try context.fetch(fetchRequest)
            return names
        } catch let fetchErr{
            print("Failed to fetch companiess: ", fetchErr)
            return []
        }
    }
}

