//
//  CellConfigurator.swift
//  DZ_ToDo_List
//
//  Created by user on 29/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class CellConfigurator {
    
    static func configureToDoCell(_ cell: UITableViewCell, for todo: ToDo) {
        cell.imageView?.image = todo.image
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.dueDate.shortFormatted
    }
    
    static func getConfiguredToDoItemCell(in controller: UITableViewController, for value: Any) -> UITableViewCell {
        
        if let strValue = value as? String {
            
            let cell = controller.tableView.dequeueReusableCell(withIdentifier: "StringCell") as! StringCell
            
            if let delegate = controller as? StringCellDelegate {
                cell.delegate = delegate
            }
            
            if controller.isEditing {
                cell.titleLabel.isHidden = true
                cell.titleField.text = strValue
                cell.titleField.isHidden = false
            } else {
                cell.titleField.isHidden = true
                cell.titleLabel.text = strValue
                cell.titleLabel.isHidden = false
            }
            
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
        
    }
    
}
