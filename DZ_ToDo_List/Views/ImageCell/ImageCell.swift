//
//  ImageCell.swift
//  DZ_ToDo_List
//
//  Created by user on 05/05/2019.
//  Copyright © 2019 Sergey Koshlakov. All rights reserved.
//

import UIKit

protocol ImageCellDelegate: class {
   func photoLibraryButtonPressed(sender: UIButton, in cell: ImageCell)
   func cameraButtonPressed(sender: UIButton, in cell: ImageCell)
}

class ImageCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    weak var delegate: ImageCellDelegate?
    
    @IBAction func actionPhotoLibraryButton(_ sender: UIButton) {
        delegate?.photoLibraryButtonPressed(sender: sender, in: self)
    }
    
    @IBAction func actionCameraButton(_ sender: UIButton) {
        delegate?.cameraButtonPressed(sender: sender, in: self)
    }
    
}
