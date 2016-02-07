//
//  CharacterID.swift
//  VFrames
//
//  Created by Andy Garron on 1/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

enum CharacterID: String {
    case RYU = "Ryu",
    CHUN = "Chun",
    DICTATOR = "Dictator",
    BIRDIE = "Birdie",
    NASH = "Nash",
    CAMMY = "Cammy",
    CLAW = "Claw",
    LAURA = "Laura",
    KEN = "Ken",
    NECALLI = "Necalli",
    RASHID = "Rashid",
    MIKA = "Mika",
    ZANGIEF = "Zangief",
    FANG = "FANG",
    DHALSIM = "Dhalsim",
    KARIN = "Karin"
    
    static let allValuesAlphabetic = [BIRDIE, CAMMY, CHUN, DHALSIM, FANG, KARIN, KEN, LAURA, DICTATOR, NASH, NECALLI, MIKA, RASHID, RYU, CLAW, ZANGIEF]
    
    static func toString(characterId: CharacterID) -> String {
        switch(characterId) {
            case .BIRDIE:
                return "Birdie"
            case .CAMMY:
                return "Cammy"
            case .CHUN:
                return "Chun-Li"
            case .CLAW:
                return "Vega"
            case .DHALSIM:
                return "Dhalsim"
            case .DICTATOR:
                return "M. Bison"
            case .FANG:
                return "F.A.N.G"
            case .KARIN:
                return "Karin"
            case .KEN:
                return "Ken"
            case .LAURA:
                return "Laura"
            case .MIKA:
                return "R. Mika"
            case .NASH:
                return "Nash"
            case .NECALLI:
                return "Necalli"
            case .RASHID:
                return "Rashid"
            case .RYU:
                return "Ryu"
            case .ZANGIEF:
                return "Zangief"
        }
    }
}
