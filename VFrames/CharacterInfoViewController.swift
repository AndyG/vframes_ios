//
//  CharacterInfoViewController.swift
//  VFrames
//
//  Created by Andy Garron on 2/6/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class CharacterInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var movesTable: UITableView!
    
    var targetCharacter : CharacterID!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(targetCharacter)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = "poop"
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionHeaders = ["One", "Two", "Three", "Four", "Five"]
        return sectionHeaders[section]
    }
}
