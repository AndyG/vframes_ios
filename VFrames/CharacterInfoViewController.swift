//
//  CharacterInfoViewController.swift
//  VFrames
//
//  Created by Andy Garron on 2/6/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class CharacterInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        moveListEntryCell.setMove(move)
        return cell!
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return moveListHeaders.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return moveListHeaders[section].rawValue
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
