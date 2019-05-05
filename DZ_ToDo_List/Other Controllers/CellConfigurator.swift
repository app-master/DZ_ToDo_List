//
//  CellConfigurator.swift
//  DZ_ToDo_List
//
//  Created by user on 29/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class CellConfigurator {
    
   static let defaultRowHeigh = CGFloat(44)
   static let customRowHeigh = CGFloat(216)
    
    static func configureToDoCell(_ cell: UITableViewCell, for todo: ToDo) {
        cell.imageView?.image = todo.image
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.dueDate.shortFormatted
    }
    
    static func getConfiguredToDoItemCell(in controller: UITableViewController, for value: Any) -> ToDoItemCell {
        
        switch value {
        case is String:
            return getConfiguredStringCell(in: controller, for: value as! String)
        case is Bool:
            return getConfiguredBoolCell(in: controller, for: value as! Bool)
        case is Date:
            return getConfiguredDateCell(in: controller, for: value as! Date)
        case is UIImage:
            return getConfiguredImageCell(in: controller, for: value as! UIImage)
        default:
            return ToDoItemCell()
        }
        
    }
    
    private static func getConfiguredStringCell(in controller: UITableViewController, for value: String) -> StringCell {
    
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "StringCell") as! StringCell
        
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
    
    private static func getConfiguredDateCell(in controller: UITableViewController, for value: Date) -> DateCell {
        
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
        
        cell.datePicker.minimumDate = Date()
        
        if controller.tableView.isEditing {
            cell.datePicker.setDate(value, animated: false)
            cell.datePicker.isHidden = false
            cell.dateLabel.isHidden = true
        } else {
            cell.dateLabel.text = value.shortFormatted
            cell.dateLabel.isHidden = false
            cell.datePicker.isHidden = true
        }
        
        return cell
    }
    
    private static func getConfiguredImageCell(in controller: UITableViewController, for value: UIImage) -> ImageCell {
        
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
        
        var image = value
        
        if image.size == CGSize.zero {
           image = UIImage(named: "placeholder.jpeg")!
        }
        
        if controller.tableView.isEditing {
            cell.photoButton.isHidden = false
            cell.photoView.isHidden = true
        } else {
            cell.photoView.image = image
            cell.photoView.isHidden = false
            cell.photoButton.isHidden = true
        }
        
        return cell
    }
    
    static func getHeighForCell(with value: Any, in controller: UITableViewController) -> CGFloat {
        
        if value is Date &&
            controller.tableView.isEditing {
            return customRowHeigh
        }
        
        if value is UIImage &&
            !controller.tableView.isEditing {
            return customRowHeigh
        }
        
        return defaultRowHeigh
        
    }
    
}
