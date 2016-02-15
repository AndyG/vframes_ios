//
//  SFCharacter.swift
//  VFrames
//
//  Created by Andy Garron on 1/30/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

class SFCharacter {
    private var moveList: [MoveCategory:Array<MoveListEntryProtocol>]
    private var frameData: FrameDataProtocol
    
    init (moveList: [MoveCategory:Array<MoveListEntryProtocol>], frameData: FrameDataProtocol) {
        self.moveList = moveList
        self.frameData = frameData
    }
        
    func getMoveList() -> [MoveCategory:Array<MoveListEntryProtocol>] {
        return moveList;
    }
    
    func getFrameData() -> FrameDataProtocol {
        return frameData
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