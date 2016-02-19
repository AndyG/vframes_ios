//
//  FrameDataViewController.swift
//  VFrames
//
//  Created by Andy Garron on 2/13/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class FrameDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var frameDataTable: UITableView!
    @IBOutlet var controlsContainerHeight: NSLayoutConstraint!
    @IBOutlet var controlsContainer: UIView!
    @IBOutlet var alternateFrameDataSwitch: UISwitch!
    @IBOutlet var frameDataStateLabel: UILabel!
    
    let frameDataHeadersOrder: Array<MoveCategory> = [
        MoveCategory.NORMALS,
        MoveCategory.UNIQUE_MOVES,
        MoveCategory.SPECIALS,
        MoveCategory.VSKILL,
        MoveCategory.VTRIGGER,
        MoveCategory.VREVERSAL,
        MoveCategory.CRITICAL_ARTS,
        MoveCategory.THROWS]
    
    
    var targetCharacterId : CharacterID!
    var targetCharacter: SFCharacter!
    
    var frameDataHeaders: Array<MoveCategory>!
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        targetCharacter = appDelegate.charactersModel.getCharacter(targetCharacterId)
        
        if (targetCharacter.getFrameData().hasAlternateFrameData()) {
            controlsContainerHeight.constant = 40
            controlsContainer.hidden = false
        } else {
            controlsContainerHeight.constant = 0
            controlsContainer.hidden = true
        }
        
        setupMoveListHeaders()
        frameDataTable.estimatedRowHeight = 150
        frameDataTable.rowHeight = UITableViewAutomaticDimension
        
        alternateFrameDataSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        updateFrameDataStateLabel()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let category = frameDataHeaders[indexPath.section]
        
        let frameDataEntryHolder = targetCharacter.getFrameData().getFromCategory(category)[indexPath.item]
        let cell = tableView.dequeueReusableCellWithIdentifier("frameDataRow") as! FrameDataEntryCell
        if (alternateFrameDataSwitch.on && frameDataEntryHolder.hasAlternate()) {
            cell.setFrameDataEntry(frameDataEntryHolder.getAlternateFrameDataEntry())
            cell.moveNameBackground.backgroundColor = UIColor().highlightedFrameDataEntryColor()
        } else {
            cell.setFrameDataEntry(frameDataEntryHolder.getFrameDataEntry())
            cell.moveNameBackground.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.03)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = frameDataHeaders[section]
        let frameDataForSection = targetCharacter.getFrameData().getFromCategory(category)
        return frameDataForSection.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return frameDataHeaders.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MoveCategory.toString(frameDataHeaders[section])
    }
    
    func stateChanged(switchState: UISwitch) {
        updateFrameDataStateLabel()
        frameDataTable.reloadData()
        //TODO: find a way to do this reloading without weird scrolling
//        let indexPaths = getIndexPathsForAlternateRows()
//        let animation = switchState.on ? UITableViewRowAnimation.Right : UITableViewRowAnimation.Left
//        frameDataTable.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    private func setupMoveListHeaders() {
        frameDataHeaders = Array<MoveCategory>()
        for moveCategory in frameDataHeadersOrder {
            let frameData = targetCharacter.getFrameData()
            let categoryExists = frameData.hasCategory(moveCategory)
            if categoryExists {
                frameDataHeaders?.append(moveCategory)
            }
        }
    }
    
    private func updateFrameDataStateLabel() {
        if alternateFrameDataSwitch.on {
            if (targetCharacterId != .CLAW) {
                frameDataStateLabel.text = "V-Trigger Frame Data"
            } else {
                frameDataStateLabel.text = "Claw On Frame Data"
            }
        } else {
            if (targetCharacterId != .CLAW) {
                frameDataStateLabel.text = "Standard Frame Data"
            } else {
                frameDataStateLabel.text = "Claw Off Frame Data"
            }
        }
    }
    
    private func getIndexPathsForAlternateRows() -> [NSIndexPath] {
        var indexPaths = [NSIndexPath]()
        for sectionIndex in 0..<frameDataHeaders.count {
            let category = frameDataHeaders[sectionIndex]
            let frameDataForCategory = targetCharacter.getFrameData().getFromCategory(category)
            
            for rowIndex in 0..<frameDataForCategory.count {
                let frameDataEntryHolder = frameDataForCategory[rowIndex]
                if frameDataEntryHolder.hasAlternate() {
                    indexPaths.append(NSIndexPath(forRow: rowIndex, inSection: sectionIndex))
                }
            }
        }
        
        return indexPaths
    }
    
}
