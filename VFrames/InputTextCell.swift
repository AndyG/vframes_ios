//
//  InputTextCell.swift
//  VFrames
//
//  Created by Andy Garron on 2/10/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class InputTextCell: UICollectionViewCell, InputElementCellProtocol {
    @IBOutlet weak var label: UILabel!
    
    func setInputElement(inputElement: InputElement) {
        switch(inputElement) {
        case .NO_INPUT:
            label.text = "No Input"
        case .OR:
            label.text = "or"
        default:
            label.text = "???"
        }
    }
    
}
