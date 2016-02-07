//
//  DataSource.swift
//  VFrames
//
//  Created by Andy Garron on 1/31/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataSource {
        
    func loadCharactersModel() -> CharactersModel {
        var characters = [CharacterID:SFCharacter]()
        characters[.BIRDIE] = loadCharacter()
        return CharactersModel(characters: characters)
    }
    
    private func loadCharacter() -> SFCharacter {
        let path = NSBundle.mainBundle().pathForResource("whole_move_list", ofType: "json")
        let data = NSData(contentsOfMappedFile: path!)!
        let jsonData = JSON(data: data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        let moveListJson = jsonData["move_list"]
        let moveList: [MoveCategory:Array<MoveListEntryProtocol>] = loadMoveList(moveListJson)
        let sfCharacter: SFCharacter = SFCharacter(moveList: moveList)
        return sfCharacter
    }
    
    private func loadMoveList(jsonData: JSON) -> [MoveCategory:Array<MoveListEntryProtocol>] {
        var moveList = [MoveCategory:Array<MoveListEntryProtocol>]()
        for (key, subJson) in jsonData {
            let category: MoveCategory = MoveCategory(rawValue: key)!
            let moveListEntries = loadMovesInCategory(subJson)
            moveList[category] = moveListEntries
        }
        
        return moveList
    }
    
    private func loadMovesInCategory(jsonData: JSON) -> Array<MoveListEntryProtocol> {
        var movesArray = Array<MoveListEntryProtocol>()
        for (_, subJson) in jsonData {
            movesArray.append(loadSingleMove(subJson))
        }
        return movesArray
    }
    
    private func loadSingleMove(jsonData: JSON) -> MoveListEntryProtocol {
        let name = jsonData["nameID"].string!
        let pretextId = jsonData["pretextID"].string
        let posttextId = jsonData["posttextID"].string
        let descriptionId = jsonData["descriptionID"].string
        let input = loadInputArray(jsonData["input"].string)
        
        let moveListEntry = MoveListEntry(nameId: name, pretextId: pretextId, posttextId: posttextId, descriptionId: descriptionId, inputElementList: input)
        
        return moveListEntry
    }
    
    private func loadInputArray (inputArray: String?) -> Array<InputElement>? {
        if let inputString = inputArray {
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