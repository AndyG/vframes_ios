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
    
    @IBOutlet weak var pretextLabel: UILabel!

    @IBOutlet weak var posttextLabel: UILabel!
    
    
    @IBOutlet weak var moveDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    
    func setMove(move: MoveListEntryProtocol, indexPath: NSIndexPath) {

        moveNameLabel.text = move.getNameId()
        
        
        if let descriptionId = move.getDescriptionId() {
            moveDescriptionLabel.text = getLocalizedString(descriptionId)
            moveDescriptionLabel.hidden = false
            moveDescriptionLabel.sizeToFit()
        } else {
            moveDescriptionLabel.text = nil
            moveDescriptionLabel.sizeToFit()
            moveDescriptionLabel.hidden = true
        }
        
        if let pretextId = move.getPretextId() {
            pretextLabel.text = getLocalizedString(pretextId)
            pretextLabel.sizeToFit()
            pretextLabel.hidden = false
        } else {
            pretextLabel.text = nil
            pretextLabel.sizeToFit()
            pretextLabel.hidden = true
        }
        
        if let posttextId = move.getPosttextId() {
            posttextLabel.text = getLocalizedString(posttextId)
            posttextLabel.sizeToFit()
            posttextLabel.hidden = false
        } else {
            posttextLabel.text = nil
            posttextLabel.sizeToFit()
            posttextLabel.hidden = true
        }
                
        inputCollectionView.setInput(move.getInput()!)
    }
    
    private func getLocalizedString(rawStringId: String) -> String {
        let localizedStringId = StringResolver.resolveString(rawStringId)
        let localizedString = NSLocalizedString(localizedStringId, comment: "")
        return localizedString
    }
}
