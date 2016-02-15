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
    
    @IBOutlet var moveDescriptionBackground: UIView!
    
    @IBOutlet weak var moveDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    
    func setMove(move: MoveListEntryProtocol, indexPath: NSIndexPath) {

        moveNameLabel.text = move.getNameId()
        
        if let descriptionText = getDescriptionText(move) {
            moveDescriptionLabel.text = descriptionText
            moveDescriptionLabel.hidden = false
            moveDescriptionLabel.sizeToFit()
        } else {
            moveDescriptionLabel.text = nil
            moveDescriptionLabel.sizeToFit()
            moveDescriptionLabel.hidden = true
        }
        
        if let pretextText = getPretextText(move) {
            pretextLabel.text = pretextText
            pretextLabel.sizeToFit()
            pretextLabel.hidden = false
        } else {
            pretextLabel.text = nil
            pretextLabel.sizeToFit()
            pretextLabel.hidden = true
        }
        
        if let posttextText = getPosttextText(move) {
            posttextLabel.text = posttextText
            posttextLabel.sizeToFit()
            posttextLabel.hidden = false
        } else {
            posttextLabel.text = nil
            posttextLabel.sizeToFit()
            posttextLabel.hidden = true
        }
                
        inputCollectionView.setInput(move.getInput()!)
    }
    
    private func getDescriptionText(move: MoveListEntryProtocol) -> String? {
        if let descriptionId = move.getDescriptionId() {
            return getLocalizedString(descriptionId)
        } else {
            return nil
        }
    }
    
    private func getPretextText(move: MoveListEntryProtocol) -> String? {
        if let pretextId = move.getPretextId() {
            return getLocalizedString(pretextId)
        } else {
            return nil
        }
    }
    
    private func getPosttextText(move: MoveListEntryProtocol) -> String? {
        if let posttextId = move.getPosttextId() {
            return getLocalizedString(posttextId)
        } else {
            return nil
        }
    }
    
    private func getLocalizedString(rawStringId: String) -> String? {
        if let localizedStringId = StringResolver.resolveString(rawStringId) {
            return NSLocalizedString(localizedStringId, comment: "")
        } else {
            return nil
        }
    }
}
