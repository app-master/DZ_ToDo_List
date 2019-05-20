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
    var dict = [String : Any]()
    
    var doneButtonPressed = false
    weak var selectedImageCell: ToDoItemCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CellConfigurator.registerToDoItemCellsIn(tableView)
        
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(actionEditButton))
        navigationItem.rightBarButtonItem = editButtonItem
        
    }
    
    // MARK: - Methods
    
    private func updateCancelButton() {
        if tableView.isEditing {
            let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(actionCancelButton))
            navigationItem.leftBarButtonItem = cancelButtonItem
        } else {
            if doneButtonPressed == true {
                let backButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(actionBackButton))
                navigationItem.leftBarButtonItem = backButtonItem
            } else {
                navigationItem.leftBarButtonItem = nil
            }
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
        
        for (key, value) in zip(todo.keys, todo.values) {
            let keyCD = key.appending("CD")
            
            if let image = value as? UIImage {
                todo.setValue(image.pngData()!, forKey: keyCD)
            } else {
                todo.setValue(value, forKey: keyCD)
            }
        }
        
        do {
            try todo.managedObjectContext?.save()
        } catch {
            print("SAVE ERROR: \(error.localizedDescription)")
        }
        
    }
    
    private func updateValue(_ value: Any, for cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let key = todo.keys[indexPath.section]
        dict.updateValue(value, forKey: key)
    }
    
    private func showAlertForSelectImageFromCell(_ cell: ToDoItemCell) {
        let alertController = UIAlertController(title: nil, message: "Select source", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                pickerController.sourceType = .camera
                self.present(pickerController, animated: true, completion: {
                    self.selectedImageCell = cell
                })
            }
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
                pickerController.sourceType = .photoLibrary
                self.present(pickerController, animated: true, completion: {
                    self.selectedImageCell = cell
                })
            }
            alertController.addAction(libraryAction)
        }
        
        present(alertController, animated: true)
    }
    
    // MARK: - Actions
    
    @objc private func actionEditButton(_ sender: UIBarButtonItem) {
        
        let isEditing = tableView.isEditing
        
        if isEditing {
            // Done button pressed
            updateToDo()
            doneButtonPressed = true
        }
        
        tableView.setEditing(!isEditing, animated: true)
        tableView.reloadData()
        
        updateBurButtonItems()
        
    }
    
    @objc private func actionCancelButton(_ sender: UIBarButtonItem) {
        
        dict.removeAll()
        
        tableView.setEditing(false, animated: true)
        tableView.reloadData()
        
        updateBurButtonItems()
    }
    
    @objc private func actionBackButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "UnwindToList", sender: sender)
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
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

// MARK: - Table View Delegate

extension ToDoItemViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let value = todo.values[indexPath.section]
        
        return CellConfigurator.getHeighForCell(with: value, in: self)
    }
    
}

// MARK: - ToDoItemCell Delegate

extension ToDoItemViewController: ToDoItemCellDelegate {
    func editingChangedCell(_ cell: ToDoItemCell, with newValue: Any) {
        updateValue(newValue, for: cell)
    }
    
    func buttonTapped(in cell: ToDoItemCell, sender: UIButton) {
        showAlertForSelectImageFromCell(cell)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ToDoItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        guard let cell = selectedImageCell as? ImageCell else { return }
        cell.photoButton.setTitle("Image selected", for: .normal)
        updateValue(image, for: cell)
        selectedImageCell = nil
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        selectedImageCell = nil
        dismiss(animated: true, completion: nil)
    }
    
}

extension ToDoItemViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

