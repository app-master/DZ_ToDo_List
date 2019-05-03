//
//  StringCell.swift
//  DZ_ToDo_List
//
//  Created by user on 29/04/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

protocol StringCellDelegate: class {
    func editingDidEndCell(_ cell: StringCell, with resultText: String)
}

class StringCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    
    weak var delegate: StringCellDelegate?
    
    @IBAction func actionFieldEditingEnd(_ textField: UITextField) {
        delegate?.editingDidEndCell(self, with: textField.text ?? "")
    }
    
}
