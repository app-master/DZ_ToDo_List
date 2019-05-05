//
//  ImageCell.swift
//  DZ_ToDo_List
//
//  Created by user on 05/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

class ImageCell: ToDoItemCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    
    @IBAction func actionPhotoButton(_ sender: UIButton) {
        delegate?.buttonTapped(in: self, sender: sender)
    }
    
}
