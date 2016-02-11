//
//  CharacterInfoViewController.swift
//  VFrames
//
//  Created by Andy Garron on 2/6/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class CharacterInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let moveListHeadersOrder: Array<MoveCategory> = [
        MoveCategory.UNIQUE_MOVES,
        MoveCategory.SPECIALS,
        MoveCategory.VSKILL,
        MoveCategory.VTRIGGER,
        MoveCategory.VREVERSAL,
        MoveCategory.CRITICAL_ARTS,
        MoveCategory.THROWS]
    
    @IBOutlet var movesTable: UITableView!
    
    var targetCharacterId : CharacterID!
    var targetCharacter: SFCharacter!
    
    var moveListHeaders: Array<MoveCategory>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movesTable.estimatedRowHeight = 150
        movesTable.rowHeight = UITableViewAutomaticDimension
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        targetCharacter = appDelegate.charactersModel.getCharacter(targetCharacterId)
        
        setupMoveListHeaders()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let moveListForSection = targetCharacter.getMoveList()[moveListHeaders![section]]
        return moveListForSection!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let category = moveListHeaders[indexPath.section]
        let move = targetCharacter.getMoveList()[category]![indexPath.item]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("descriptionCell")
        let moveListEntryCell = cell as! MoveListCellProtocol
        moveListEntryCell.setMove(move, indexPath: indexPath)
        return cell!
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return moveListHeaders.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MoveCategory.toString(moveListHeaders[section])
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let move = getMoveForIndexPath(indexPath)
        var height = tableView.estimatedRowHeight
        
        if (move.getDescriptionId() != nil) {
            height += 40
        }
        
        if move.getPretextId() != nil {
            height += 20
        }
        
        if move.getPosttextId() != nil {
            height += 20
        }
        
        return height
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        let inputCollectionView = collectionView as! InputCollectionView
        return inputCollectionView.getInputArray().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let inputCollectionView = collectionView as! InputCollectionView
        let inputElement = inputCollectionView.getInputArray()[indexPath.item]
        
        var cellReuseId: String = "inputIconCell"
        if (inputElement == InputElement.NO_INPUT || inputElement == InputElement.OR) {
            cellReuseId = "inputTextCell"
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseId, forIndexPath: indexPath) as! InputElementCellProtocol
        cell.setInputElement(inputElement)
        
        return cell as! UICollectionViewCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let inputArray = (collectionView as! InputCollectionView).getInputArray()
        let inputElement = inputArray[indexPath.item]
        
        if (inputElement == InputElement.OR) {
            return CGSize(width: 25.0, height: 25.0)
        } else if (inputElement == InputElement.NO_INPUT) {
            return CGSize(width: 70.0, height: 20.0)
        }
        
        //Add 1 to ensure we'll always fit!
        let numInputElements = inputArray.count + 1
        
        let collectionViewWidth = collectionView.frame.size.width
        let cellPadding = CGFloat(5)
        
        let fitSize = (collectionViewWidth / CGFloat(numInputElements)) - cellPadding
        let maxSize = CGFloat(40)

        var recommendedWidth = min(fitSize, maxSize)
        var recommendedHeight = recommendedWidth
        
        //If we're looking at an arrow or a plus, shrink them
        if (inputElement == InputElement.ARROW || inputElement == InputElement.PLUS) {
            recommendedWidth *= 0.5
            recommendedHeight *= 0.5
        } else if (inputElement == InputElement.ALL_PUNCHES || inputElement == InputElement.ALL_KICKS) {
            //If we're looking at 3P or 3K, scale the width up a bit
            recommendedWidth *= 1.7
        }
        
        return CGSize(width: recommendedWidth, height: recommendedHeight)
    }
    
    private func getMoveForIndexPath(indexPath: NSIndexPath) -> MoveListEntryProtocol {
        let category = moveListHeaders[indexPath.section]
        return targetCharacter.getMoveList()[category]![indexPath.item]
    }
    
    private func setupMoveListHeaders() {
        moveListHeaders = Array<MoveCategory>()
        for moveCategory in moveListHeadersOrder {
            let categoryExists = targetCharacter.getMoveList()[moveCategory] != nil
            if categoryExists {
                moveListHeaders?.append(moveCategory)
            }
        }
    }
}
