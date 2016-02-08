//
//  SimpleMoveListCell.swift
//  VFrames
//
//  Created by Andy Garron on 2/7/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class SimpleMoveListCell: UITableViewCell, MoveListCellProtocol {
    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var moveInputLabel: UILabel!
    
    func setMove(move: MoveListEntryProtocol) {
        moveNameLabel.text = move.getNameId()        
        moveInputLabel.text = "simple input"
    }
}
