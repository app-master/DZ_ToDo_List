//
//  StringCell.swift
//  DZ_ToDo_List
//
//  Created by user on 29/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class StringCell: ToDoItemCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    
    @IBAction func actionEditingChanged(_ textField: UITextField) {
        delegate?.editingChangedCell(self, with: textField.text ?? "")
    }
    
}
