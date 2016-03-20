//
//  DataSource.swift
//  VFrames
//
//  Created by Andy Garron on 1/31/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

class CharactersModelJsonAdapter {
        
    func loadCharactersModel(charactersModelJson: JSON) -> CharactersModel {
        print("loading characters model")
                
        let version = Int(charactersModelJson["version"].string!)!
        
        let charactersJson = charactersModelJson["characters"]
        var characters = [CharacterID:SFCharacter]()
        for characterId in CharacterID.allValuesAlphabetic {
            print("Parsing character: \(characterId.rawValue)")
            let characterJsonId = getJsonIdForCharacter(characterId)
            let characterJson = charactersJson[characterJsonId]
            
            if (characterJson != nil) {
                characters[characterId] = loadCharacter(characterJson)
            } else {
                characters[characterId] = SFCharacter(moveList: nil, frameData: nil, bnbCombos: nil)
            }
        }
        return CharactersModel(characters: characters, version: version)
    }
    
    private func loadCharacter(characterJson: JSON) -> SFCharacter {
        
        var moveList: [MoveCategory:Array<MoveListEntryProtocol>]? = nil
        var frameData: FrameDataProtocol? = nil
        var bnbModel: BreadAndButterModel? = nil
        
        let moveListJson = characterJson["move_list"]
        if moveListJson != nil {
            moveList = MoveListLoader.loadMoveList(moveListJson)
        }
        
        let frameDataJson = characterJson["frame_data"]
        if frameDataJson != nil {
            frameData = FrameDataLoader.loadFrameData(frameDataJson)
        }
        
        let bnbCombosJson = characterJson["bnb_combos"]
        if (bnbCombosJson != nil) {
            bnbModel = BnbsLoader.loadCombos(bnbCombosJson.arrayValue)
        }
        
        let sfCharacter: SFCharacter = SFCharacter(moveList: moveList, frameData: frameData, bnbCombos: bnbModel)
        return sfCharacter
    }
    
    
    private func getJsonIdForCharacter(characterId: CharacterID) -> String {
        var fileName: String!
        
        switch(characterId) {
        case .ALEX:
            fileName = "alex"
        case .BIRDIE:
            fileName = "birdie"
        case .CAMMY:
            fileName = "cammy"
        case .CHUN:
            fileName = "chun"
        case .CLAW:
            fileName = "claw"
        case .DHALSIM:
            fileName = "dhalsim"
        case .DICTATOR:
            fileName = "dictator"
        case .FANG:
            fileName = "fang"
        case .KARIN:
            fileName = "karin"
        case .KEN:
            fileName = "ken"
        case .LAURA:
            fileName = "laura"
        case .MIKA:
            fileName = "mika"
        case .NASH:
            fileName = "nash"
        case .NECALLI:
            fileName = "necalli"
        case .RASHID:
            fileName = "rashid"
        case .RYU:
            fileName = "ryu"
        case .ZANGIEF:
            fileName = "zangief"
        }
        
        return fileName
    }
}