//
//  ToDoItemCell.swift
//  DZ_ToDo_List
//
//  Created by user on 05/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

protocol ToDoItemCellDelegate: class {
    func editingDidEndCell(_ cell: ToDoItemCell, with newValue: Any)
    func buttonTapped(in cell: ToDoItemCell, sender: UIButton)
}

extension ToDoItemCellDelegate {
    func editingDidEndCell(_ cell: ToDoItemCell, with newValue: Any) {}
    func buttonTapped(in cell: ToDoItemCell, sender: UIButton) {}
}

class ToDoItemCell: UITableViewCell {
    weak var delegate: ToDoItemCellDelegate?
}
