//
//  ToDo.swift
//  DZ_ToDo_List
//
//  Created by user on 29/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

@objcMembers class ToDo: NSObject {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String
    var image: UIImage
    var priority: Int
    
    init(title: String,
         isComplete: Bool,
         dueDate: Date,
         notes: String,
         image: UIImage,
         priority: Int) {
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
        self.image = image
        self.priority = priority
    }
    
    convenience override init() {
        self.init(title: String(),
                  isComplete: Bool(),
                  dueDate: Date(),
                  notes: String(),
                  image: UIImage(),
                  priority: 0)
    }
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
        return loadSampleData()
    }
    
    static func loadSampleData() -> Todos {
        return [
            ToDo(title: "Купить крем", isComplete: false, dueDate: Date(), notes: "Для загара", image: UIImage(), priority: 2),
            ToDo(title: "Сходить на выставку", isComplete: false, dueDate: Date().addingTimeInterval(60 * 60 * 24), notes: "Выставка Эдварда Мунка", image: UIImage(named: "scream.jpeg")!, priority: 1),
            ToDo(title: "Заработать 10000$", isComplete: false, dueDate: Date().addingTimeInterval(60 * 60 * 24 * 180), notes: "", image: UIImage(), priority: 0)
        ]
    }
    
}
