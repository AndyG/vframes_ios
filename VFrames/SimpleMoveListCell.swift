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
    @IBOutlet weak var inputCollectionView: InputCollectionView!
    
    var move: MoveListEntryProtocol!
    
    func setMove(move: MoveListEntryProtocol, indexPath: NSIndexPath) {
        self.move = move
        moveNameLabel.text = move.getNameId()
        inputCollectionView.setInput(move.getInput()!)
    }
}
