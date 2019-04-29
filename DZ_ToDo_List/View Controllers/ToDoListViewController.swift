//
//  ToDoListViewController.swift
//  DZ_ToDo_List
//
//  Created by user on 29/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var todos = Todos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - Custom Methods
    
    private func loadData() {
        if let todos = Todos.loadData() {
            self.todos = todos
        } else {
            self.todos = Todos.loadSampleData()
        }
    }

}

// MARK: - Table View Data Source

extension ToDoListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell")!
        
        let todo = todos[indexPath.row]
        
        CellConfigurator.configureToDoCell(cell, for: todo)
        
        return  cell
    }
    
}

// MARK: - Table View Delegate

extension ToDoListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let todo = todos[indexPath.row]
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ToDoItemViewController") as? ToDoItemViewController else { return }
        
        vc.todo = todo
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: - Segue

//extension ToDoListViewController {
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "AddToDoSegue" {
//            
//        }
//        
//    }
//    
//}
