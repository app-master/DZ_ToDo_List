//
//  IntCell.swift
//  DZ_ToDo_List
//
//  Created by user on 06/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class IntCell: ToDoItemCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.editingChangedCell(self, with: sender.selectedSegmentIndex)
    }
    
}
