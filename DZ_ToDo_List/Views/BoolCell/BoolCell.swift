//
//  BoolCell.swift
//  DZ_ToDo_List
//
//  Created by user on 04/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

protocol BoolCellDelegate: class {
    func switchValueChangedInCell(_ cell: BoolCell, newValue: Bool)
}

class BoolCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var theSwitch: UISwitch!
    
    weak var delegate: BoolCellDelegate?
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        delegate?.switchValueChangedInCell(self, newValue: sender.isOn)
    }
    
    
}
