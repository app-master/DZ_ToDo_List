//
//  ToDoItemViewController.swift
//  DZ_ToDo_List
//
//  Created by user on 29/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class ToDoItemViewController: UITableViewController {

    var todo: ToDo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "StringCell", bundle: nil), forCellReuseIdentifier: "StringCell")
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView.reloadData()
    }
    
}

// MARK: - Table View Data Source

extension ToDoItemViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return todo.keys.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return todo.formattedKeys[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let value = todo.values[indexPath.section]
        
        let cell = CellConfigurator.getConfiguredToDoItemCell(in: self, for: value)
        
        return cell
    }
    
}

extension ToDoItemViewController: StringCellDelegate {
    func editingDidEndCell(_ cell: StringCell, with resultText: String?) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        print(todo.keys[indexPath.section])
    }
}
