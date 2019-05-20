//
//  ToDo+CoreDataClass.swift
//  DZ_ToDo_List
//
//  Created by user on 20/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(ToDo)
@objcMembers public class ToDo: NSManagedObject {

   var title: String = ""
   var isComplete: Bool = false
   var dueDate: Date = Date()
   var notes: String = ""
   var image: UIImage = UIImage()
   var priority: Int = 0
    
   static func newToDo() -> ToDo {
    
        let context = DataManager.manager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ToDo", in: context)!
        
        let todo = NSManagedObject(entity: entity, insertInto: context) as! ToDo
        todo.title = ""
        todo.isComplete = false
        todo.dueDate = Date()
        todo.notes = ""
        todo.image = UIImage(named: "placeholder1")!
        todo.priority = 0
        
        return todo
    }
    
}
