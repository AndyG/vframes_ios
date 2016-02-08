//
//  MoveCategory.swift
//  VFrames
//
//  Created by Andy Garron on 1/30/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

enum MoveCategory: String {
    case NORMALS = "normals",
    SPECIALS = "specials",
    VSKILL = "vskill",
    VTRIGGER = "vtrigger",
    VREVERSAL = "vreversal",
    CRITICAL_ARTS = "critical_arts",
    UNIQUE_MOVES = "unique_attacks",
    THROWS = "throws"
    
    static func toString(moveCategory: MoveCategory) -> String {
        switch(moveCategory) {
            case .NORMALS:
                return "Normals"
            case .SPECIALS:
                return "Specials"
            case .VSKILL:
                return "V-Skill"
            case .VTRIGGER:
                return "V-Trigger"
            case .VREVERSAL:
                return "V-Reversal"
            case .CRITICAL_ARTS:
                return "Critical Arts"
            case .UNIQUE_MOVES:
                return "Unique Moves"
            case .THROWS:
                return "Throws"
        }
    }
}