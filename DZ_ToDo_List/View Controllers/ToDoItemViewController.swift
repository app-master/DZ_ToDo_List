//
//  ToDoItemViewController.swift
//  DZ_ToDo_List
//
//  Created by user on 29/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class ToDoItemViewController: UITableViewController {

    var todo = ToDo()
    var dict = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "StringCell", bundle: nil), forCellReuseIdentifier: "StringCell")
        
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(actionEditButton))
        navigationItem.rightBarButtonItem = editButtonItem
        
    }
    
    // MARK: - Methods
    
    private func updateCancelButton() {
        if tableView.isEditing {
            let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(actionCancelButton))
            navigationItem.leftBarButtonItem = cancelButtonItem
        } else {
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    private func updateEditButton() {
        var item = UIBarButtonItem.SystemItem.edit
        
        if tableView.isEditing {
            item = UIBarButtonItem.SystemItem.done
        }
        
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: item, target: self, action: #selector(actionEditButton))
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    private func updateBurButtonItems() {
        updateCancelButton()
        updateEditButton()
    }
    
    private func updateToDo() {
        for (key, value) in dict {
            todo.setValue(value, forKey: key)
        }
        dict.removeAll()
    }
    
    @objc private func actionEditButton(_ sender: UIBarButtonItem) {
        
        let isEditing = tableView.isEditing
        
        if isEditing {
            // Done button pressed
            tableView.endEditing(true)
            updateToDo()
        }
        
        tableView.setEditing(!isEditing, animated: true)
        tableView.reloadData()
        
        updateBurButtonItems()
        
    }
    
    @objc func actionCancelButton(_ sender: UIBarButtonItem) {
        
        dict.removeAll()
        
        tableView.setEditing(false, animated: true)
        tableView.reloadData()
        
        updateBurButtonItems()
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
    func editingDidEndCell(_ cell: StringCell, with resultText: String) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let key = todo.keys[indexPath.section]
        let value = resultText
        dict.updateValue(value, forKey: key)
    }
}
