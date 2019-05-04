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
        
        switch value {
        case is String:
            return getConfiguredStringCell(in: controller, for: value as! String)
        case is Bool:
            return getConfiguredBoolCell(in: controller, for: value as! Bool)
        default:
            return UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
        }
        
    }
    
    private static func getConfiguredStringCell(in controller: UITableViewController, for value: String) -> StringCell {
    
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "StringCell") as! StringCell
        
        if let delegate = controller as? StringCellDelegate {
            cell.delegate = delegate
        }
        
        if controller.tableView.isEditing {
            cell.titleLabel.isHidden = true
            cell.titleField.text = value
            cell.titleField.isHidden = false
        } else {
            cell.titleField.isHidden = true
            cell.titleLabel.text = value
            cell.titleLabel.isHidden = false
        }
        
        return cell
    }
    
    private static func getConfiguredBoolCell(in controller: UITableViewController, for value: Bool) -> BoolCell {
    
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "BoolCell") as! BoolCell
        
        if let delegate = controller as? BoolCellDelegate {
            cell.delegate = delegate
        }
        
        if controller.tableView.isEditing {
            cell.theSwitch.setOn(value, animated: false)
            cell.theSwitch.isHidden = false
            cell.titleLabel.isHidden = true
        } else {
            cell.titleLabel.text = value ? "True" : "False"
            cell.titleLabel.isHidden = false
            cell.theSwitch.isHidden = true
        }
        
        return cell
    }
}
