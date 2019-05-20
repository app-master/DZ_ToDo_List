//
//  ToDo+CoreDataProperties.swift
//  DZ_ToDo_List
//
//  Created by user on 20/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var dueDateCD: NSDate?
    @NSManaged public var imageCD: NSData?
    @NSManaged public var isCompleteCD: Bool
    @NSManaged public var notesCD: String?
    @NSManaged public var priorityCD: Int16
    @NSManaged public var titleCD: String?

}

extension ToDo {
    
    var formattedKeys: [String] {
        return keys.map { $0.capitalizedWithSpace }
    }
    
    var keys: [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    var values: [Any] {
        return Mirror(reflecting: self).children.map { $0.value }
    }
    
}

typealias Todos = [ToDo]

extension Todos {
    
    static func loadData() -> Todos? {
        
        let request: NSFetchRequest<ToDo>  = ToDo.fetchRequest()
        
        let context = DataManager.manager.persistentContainer.viewContext
        
        let results = try? context.fetch(request)
        
        return results
    }
    
    static func loadSampleData() -> Todos {
        return []
    }
    
}
