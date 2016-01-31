//
//  SFCharacter.swift
//  VFrames
//
//  Created by Andy Garron on 1/30/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

class SFCharacter {
    var moveList: [MoveCategory:Array<MoveListEntryProtocol>]
    
    init (moveList: [MoveCategory:Array<MoveListEntryProtocol>]) {
        self.moveList = moveList
    }
        
    func getMoveList() -> [MoveCategory:Array<MoveListEntryProtocol>] {
        return moveList;
    }
    
    func getStringRepresentation() -> String {
        var stringRepresentation = String()
        for (moveCategory, moves) in moveList {
            stringRepresentation += "\(moveCategory)\n"
            
            for move in moves {
                let castedMove = move as! MoveListEntry
                stringRepresentation += "\(castedMove.getStringRepresentation())\n"
            }
        }
        
        return stringRepresentation
    }
}