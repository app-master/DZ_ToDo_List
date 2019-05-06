//
//  BoolCell.swift
//  DZ_ToDo_List
//
//  Created by user on 04/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class BoolCell: ToDoItemCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var theSwitch: UISwitch!
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        delegate?.editingChangedCell(self, with: sender.isOn)
    }
    
}
