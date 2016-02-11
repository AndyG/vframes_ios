//
//  InputElementCell.swift
//  VFrames
//
//  Created by Andy Garron on 2/7/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class InputElementCell: UICollectionViewCell {
    @IBOutlet weak var inputImage: UIImageView!
    
    func setInput(inputElement: InputElement) {
        inputImage.image = UIImage(named: "input_direction_down")
    }
    
}
