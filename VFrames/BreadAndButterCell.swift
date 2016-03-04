//
//  BreadAndButterCell.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

public class BreadAndButterCell: UITableViewCell {
    
    @IBOutlet var comboLabel: UILabel!
    @IBOutlet var comboInputs: UILabel!
    @IBOutlet var comboDescription: UILabel!
    
    public func setCombo(combo: BreadAndButterCombo) {
        
        comboLabel.text = combo.getLabel()
        comboLabel.sizeToFit()
        
        comboInputs.text = combo.getInputs()
        comboInputs.sizeToFit()
        
        comboDescription.text = combo.getDescription()
        comboDescription.sizeToFit()
    }

}
