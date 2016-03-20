//
//  BnBViewController.swift
//  VFrames
//
//  Created by Andy Garron on 3/2/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class BnBViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var targetCharacterId: CharacterID!
    var breadAndButters: BreadAndButterModel?
    
    @IBOutlet var bnbsTableView: UITableView!
    @IBOutlet var noCombosLabel: UILabel!
    
    private var tableHeaders: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let character = appDelegate.charactersModel.getCharacter(targetCharacterId)
        
        if character.getBreadAndButterCombos() != nil {
            bnbsTableView.hidden = false
            breadAndButters = character.getBreadAndButterCombos()!
            setupBnbsHeaders()
            bnbsTableView.estimatedRowHeight = 150
            //        bnbsTableView.rowHeight = UITableViewAutomaticDimension
        } else {
            tableHeaders = Array<String>()
            breadAndButters = nil
            bnbsTableView.hidden = true
            noCombosLabel.hidden = false
        }
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let category = tableHeaders[indexPath.section]
        let combo = breadAndButters!.getCombosForCategory(category)[indexPath.item]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("breadAndButterCell")
        
        let breadAndButterCell = cell as! BreadAndButterCell
        breadAndButterCell.setCombo(combo)
        return breadAndButterCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = tableHeaders[section]
        return breadAndButters!.getCombosForCategory(category).count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableHeaders.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableHeaders[section]
    }
    
    private func setupBnbsHeaders() {
        tableHeaders = Array<String>()
        for category in breadAndButters!.getCategories() {
            tableHeaders.append(category)
        }
    }

}
