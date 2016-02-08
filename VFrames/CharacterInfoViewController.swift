//
//  CharacterInfoViewController.swift
//  VFrames
//
//  Created by Andy Garron on 2/6/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class CharacterInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let moveListHeadersOrder: Array<MoveCategory> = [
        MoveCategory.UNIQUE_MOVES,
        MoveCategory.SPECIALS,
        MoveCategory.VSKILL,
        MoveCategory.VTRIGGER,
        MoveCategory.VREVERSAL,
        MoveCategory.CRITICAL_ARTS,
        MoveCategory.THROWS]
    
    @IBOutlet weak var movesTable: UITableView!
    
    var targetCharacterId : CharacterID!
    var targetCharacter: SFCharacter!
    
    var moveListHeaders: Array<MoveCategory>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(targetCharacterId)
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
        
        var cellReuseId: String! = "simpleCell"
        if move.getDescriptionId() != nil {
            cellReuseId = "descriptionCell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseId)
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let category = moveListHeaders[indexPath.section]
        let move = targetCharacter.getMoveList()[category]![indexPath.item]
        if (move.getDescriptionId() != nil) {
            return CGFloat(tableView.rowHeight + 50)
        } else {
            return tableView.rowHeight
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        let inputCollectionView = collectionView as! InputCollectionView
        return inputCollectionView.getInputArray().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("inputCell", forIndexPath: indexPath) as! InputElementCell
        
        let inputCollectionView = collectionView as! InputCollectionView
        cell.setInput(inputCollectionView.getInputArray()[indexPath.item])
        
        return cell
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
