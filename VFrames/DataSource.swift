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
        for characterId in CharacterID.allValuesAlphabetic {
            characters[characterId] = loadCharacter(characterId)
        }
        return CharactersModel(characters: characters)
    }
    
    private func loadCharacter(characterId: CharacterID) -> SFCharacter {
        let path = NSBundle.mainBundle().pathForResource(getFileNameForCharacter(characterId), ofType: "json")
        let url = NSURL(fileURLWithPath: path!)
        let data = NSData(contentsOfURL: url)!
        let jsonData = JSON(data: data, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        let moveListJson = jsonData["move_list"]
        let moveList: [MoveCategory:Array<MoveListEntryProtocol>] = MoveListLoader.loadMoveList(moveListJson)
        
        let frameDataJson = jsonData["frame_data"]
        let frameData: FrameDataProtocol = FrameDataLoader.loadFrameData(frameDataJson)
        
        let sfCharacter: SFCharacter = SFCharacter(moveList: moveList, frameData: frameData)
        return sfCharacter
    }
    
    
    private func getFileNameForCharacter(characterId: CharacterID) -> String {
        var fileName: String!
        
        switch(characterId) {
        case .BIRDIE:
            fileName = "birdie_data"
        case .CAMMY:
            fileName = "cammy_data"
        case .CHUN:
            fileName = "chun_data"
        case .CLAW:
            fileName = "claw_data"
        case .DHALSIM:
            fileName = "dhalsim_data"
        case .DICTATOR:
            fileName = "dictator_data"
        case .FANG:
            fileName = "fang_data"
        case .KARIN:
            fileName = "karin_data"
        case .KEN:
            fileName = "ken_data"
        case .LAURA:
            fileName = "laura_data"
        case .MIKA:
            fileName = "mika_data"
        case .NASH:
            fileName = "nash_data"
        case .NECALLI:
            fileName = "necalli_data"
        case .RASHID:
            fileName = "rashid_data"
        case .RYU:
            fileName = "ryu_data"
        case .ZANGIEF:
            fileName = "zangief_data"
        }
        
        return fileName
    }
}