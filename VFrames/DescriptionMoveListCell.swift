//
//  MoveListCell.swift
//  VFrames
//
//  Created by Andy Garron on 2/7/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class DescriptionMoveListCell: UITableViewCell, MoveListCellProtocol {
    @IBOutlet weak var inputCollectionView: InputCollectionView!
    @IBOutlet weak var moveNameLabel: UILabel!
    @IBOutlet weak var moveDescriptionLabel: UILabel!
    
    func setMove(move: MoveListEntryProtocol, indexPath: NSIndexPath) {
        moveNameLabel.text = move.getNameId()
        moveDescriptionLabel.text = move.getDescriptionId()
        inputCollectionView.setInput(move.getInput()!)
    }
}
