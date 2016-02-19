//
//  MoveListLoader.swift
//  VFrames
//
//  Created by Andy Garron on 2/13/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

public class MoveListLoader {
    
    static func loadMoveList(jsonData: JSON) -> [MoveCategory:Array<MoveListEntryProtocol>] {
        var moveList = [MoveCategory:Array<MoveListEntryProtocol>]()
        for (key, subJson) in jsonData {
            let category: MoveCategory = MoveCategory(rawValue: key)!
            let moveListEntries = loadMovesInCategory(subJson)
            moveList[category] = moveListEntries
        }
        
        return moveList
    }
    
    private static func loadMovesInCategory(jsonData: JSON) -> Array<MoveListEntryProtocol> {
        var movesArray = Array<MoveListEntryProtocol>()
        for (_, subJson) in jsonData {
            movesArray.append(loadSingleMove(subJson))
        }
        return movesArray
    }
    
    private static func loadSingleMove(jsonData: JSON) -> MoveListEntryProtocol {
        let name = jsonData["nameID"].string!
        let pretextId = jsonData["pretextID"].string
        let posttextId = jsonData["posttextID"].string
        let descriptionId = jsonData["description"].string
        if (descriptionId != nil) {
            print("Loaded description: \(descriptionId)")
        }
        let input = loadInputArray(jsonData["input"].string)
        
        let moveListEntry = MoveListEntry(nameId: name, pretextId: pretextId, posttextId: posttextId, descriptionId: descriptionId, inputElementList: input)
        
        return moveListEntry
    }
    
    private static func loadInputArray (inputArray: String?) -> Array<InputElement>? {
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