//
//  ViewController.swift
//  VFrames
//
//  Created by Andy Garron on 1/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(CharacterID.CHUN)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func characterButtonClicked(sender: UIButton) {
        switch (sender.tag) {
            case 0:
                print("ryu clicked")
            case 1:
                print ("chun clicked")
        default:
            print ("invalid clicked")
        }
    }
    
    @IBAction func loadDataPressed(sender: UIButton) {
        print("loadDataPressed")
        var sfCharacter = loadCharacter()
        print("characterLoaded")
        print(sfCharacter.getStringRepresentation())
    }
    
    func loadCharacter() -> SFCharacter {
        let path = NSBundle.mainBundle().pathForResource("whole_move_list", ofType: "json")
        let data = NSData(contentsOfMappedFile: path!)!
        let jsonData = JSON(data: data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        let moveListJson = jsonData["move_list"]
        let moveList: [MoveCategory:Array<MoveListEntryProtocol>] = loadMoveList(moveListJson)
        let sfCharacter: SFCharacter = SFCharacter(moveList: moveList)
        return sfCharacter
    }
    
    func loadMoveList(jsonData: JSON) -> [MoveCategory:Array<MoveListEntryProtocol>] {
        var moveList = [MoveCategory:Array<MoveListEntryProtocol>]()
        for (key, subJson) in jsonData {
            let category: MoveCategory = MoveCategory(rawValue: key)!
            let moveListEntries = loadMovesInCategory(subJson)
            moveList[category] = moveListEntries
        }
       
        return moveList
    }
    
    func loadMovesInCategory(jsonData: JSON) -> Array<MoveListEntryProtocol> {
        var movesArray = Array<MoveListEntryProtocol>()
        for (_, subJson) in jsonData {
            movesArray.append(loadSingleMove(subJson))
        }
        return movesArray
    }
    
    func loadSingleMove(jsonData: JSON) -> MoveListEntryProtocol {
        let name = jsonData["nameID"].string!
        let pretextId = jsonData["pretextID"].string
        let posttextId = jsonData["posttextID"].string
        let descriptionId = jsonData["descriptionID"].string
        let input = loadInputArray(jsonData["input"])
        
        let moveListEntry = MoveListEntry(nameId: name, pretextId: pretextId, posttextId: posttextId, descriptionId: descriptionId, inputElementList: input)
        
        return moveListEntry
    }
    
    func loadInputArray (inputArray: JSON) -> Array<InputElement>? {
        if let inputString = inputArray.string {
            var inputArray = Array<InputElement>()
            let inputComponents = inputString.componentsSeparatedByString("|")
            for inputElementString in inputComponents {
                inputArray.append(InputElement(rawValue: inputElementString)!)
            }
            return inputArray
        }
        
        return nil
    }
}

