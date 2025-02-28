//
//  FrameDataEntryCell.swift
//  VFrames
//
//  Created by Andy Garron on 2/13/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class FrameDataEntryCell: UITableViewCell {
    
    @IBOutlet var superView: UIView!
    @IBOutlet var moveNameLabel: UILabel!
    @IBOutlet var startupFramesLabel: UILabel!
    @IBOutlet var activeFramesLabel: UILabel!
    @IBOutlet var moveNameBackground: UIView!
    @IBOutlet var recoveryFramesLabel: UILabel!
    @IBOutlet var blockAdvantageLabel: UILabel!
    @IBOutlet var hitAdvantageLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var descBackground: UIView!
    
    private static let DISPLAY_CODE_MISSING_VALUE = 1001;
    private static let DISPLAY_CODE_NOT_APPLICABLE = 1002;
    private static let DISPLAY_CODE_KNOCKDOWN = 1003;
    private static let DISPLAY_CODE_GUARD_BREAK = 1004;
    private static let DISPLAY_CODE_CRUMPLE = 1005;
    
    func setFrameDataEntry(frameDataEntry: FrameDataEntryProtocol) {
        moveNameLabel.text = frameDataEntry.getDisplayName()
        
        startupFramesLabel.text = getDisplayString(frameDataEntry.getStartupFrames())
        activeFramesLabel.text = getDisplayString(frameDataEntry.getActiveFrames())
        recoveryFramesLabel.text = getDisplayString(frameDataEntry.getRecoveryFrames())
        
        blockAdvantageLabel.text = getDisplayString(frameDataEntry.getBlockAdvantage())
        hitAdvantageLabel.text = getDisplayString(frameDataEntry.getHitAdvantage())
        
        if let descriptionText = frameDataEntry.getDescription() {
            print("found description: \(descriptionText)")
            descriptionLabel.text = descriptionText
            descriptionLabel.hidden = false
            print("height: \(descriptionLabel.frame.height)")
            print("height: \(descBackground.frame.height)")
            descriptionLabel.sizeToFit()
            
            let backgroundConstraints = descBackground.constraints
            
            for constraint in backgroundConstraints {
                if let id = constraint.identifier {
                    if id == "zeroHeightConstraint" {
                        print("removed constraint")
                        descBackground.removeConstraint(constraint)
                    }
                }
            }
            
        } else {
            descriptionLabel.text = nil
            descriptionLabel.sizeToFit()
            
            let heightConstraint = NSLayoutConstraint(item: descBackground, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 0)
            heightConstraint.priority = 1000
            heightConstraint.identifier = "zeroHeightConstraint"
            descBackground.addConstraint(heightConstraint)

            descriptionLabel.hidden = true
        }
    }
    
    private func getDisplayString(valueEntry: Int) -> String {
        switch (valueEntry) {
            case FrameDataEntryCell.DISPLAY_CODE_MISSING_VALUE:
                return "-"
            case FrameDataEntryCell.DISPLAY_CODE_NOT_APPLICABLE:
                return "n/a"
            case FrameDataEntryCell.DISPLAY_CODE_KNOCKDOWN:
                return "K/D"
            case FrameDataEntryCell.DISPLAY_CODE_GUARD_BREAK:
                return "Guard Break"
            case FrameDataEntryCell.DISPLAY_CODE_CRUMPLE:
                return "Crumple"
            default:
                return String(valueEntry)
        }
    }
}
