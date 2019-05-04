//
//  DateCell.swift
//  DZ_ToDo_List
//
//  Created by user on 04/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

protocol DateCellDelegate: class {
    func editingDidEndCell(_ cell: UITableViewCell, with newValue: Any)
}

class DateCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: DateCellDelegate?
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        delegate?.editingDidEndCell(self, with: sender.date)
    }
    
}
