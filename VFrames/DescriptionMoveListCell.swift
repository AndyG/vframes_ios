//
//  MoveListCell.swift
//  VFrames
//
//  Created by Andy Garron on 2/7/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class DescriptionMoveListCell: UITableViewCell, MoveListCellProtocol {
    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var moveInputLabel: UILabel!
    @IBOutlet weak var moveDescriptionLabel: UILabel!
    
    func setMove(move: MoveListEntryProtocol) {
        moveNameLabel.text = move.getNameId()
        moveInputLabel.text = "description input"
        moveDescriptionLabel.text = move.getDescriptionId()
    }
}
