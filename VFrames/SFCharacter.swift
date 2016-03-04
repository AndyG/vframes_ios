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
    private var bnbCombos: BreadAndButterModel        
    
    init (moveList: [MoveCategory:Array<MoveListEntryProtocol>], frameData: FrameDataProtocol, bnbCombos: BreadAndButterModel) {
        self.moveList = moveList
        self.frameData = frameData
        self.bnbCombos = bnbCombos
    }
        
    func getMoveList() -> [MoveCategory:Array<MoveListEntryProtocol>] {
        return moveList;
    }
    
    func getFrameData() -> FrameDataProtocol {
        return frameData
    }
    
    func getBreadAndButterCombos() -> BreadAndButterModel {
        return bnbCombos
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