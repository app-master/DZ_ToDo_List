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
        
        CellConfigurator.registerToDoCellsIn(tableView)
        
        loadData()
    }
    
    // MARK: - Custom Methods
    
    private func loadData() {
        if let todos = Todos.loadData(), todos.count > 0 {
            for todo in todos {
                for key in todo.keys {
                    let keyCD = key.appending("CD")
                    let value = todo.value(forKey: keyCD)
                    
                    if value is NSData {
                        todo.setValue(UIImage(data: value as! Data), forKey: key)
                    } else {
                        todo.setValue(value, forKey: key)
                    }
                }
            }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoCell
        
        let todo = todos[indexPath.row]
        
        CellConfigurator.configureToDoCell(cell, for: todo)
        
        return  cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todo = todos[indexPath.row]
            todos.remove(at: indexPath.row)
            let context = DataManager.manager.persistentContainer.viewContext
            context.delete(todo)
            try? context.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

// MARK: - Table View Delegate

extension ToDoListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todo = todos[indexPath.row]
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ToDoItemViewController") as? ToDoItemViewController else { return }
        
        vc.todo = todo
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellConfigurator.defaultRowHeigh
    }
    
}

// MARK: - Segue

extension ToDoListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddToDoSegue" {
            let vc = segue.destination as! ToDoItemViewController
            vc.todo = ToDo.newToDo()
        }
        
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "UnwindToList" {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            if let indexPath = selectedIndexPath {
                tableView.beginUpdates()
                tableView.reloadRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                tableView.deselectRow(at: indexPath, animated: true)
            } else {
                let vc = unwindSegue.source as! ToDoItemViewController
                let newToDo = vc.todo
                todos.append(newToDo!)
                let newIndexPath = IndexPath(row: todos.count - 1, section: 0)
                tableView.beginUpdates()
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
    }
    
}
