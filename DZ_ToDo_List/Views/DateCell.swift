//
//  DateCell.swift
//  DZ_ToDo_List
//
//  Created by user on 04/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class DateCell: ToDoItemCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        delegate?.editingChangedCell(self, with: sender.date)
    }
    
}
