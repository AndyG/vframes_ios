//
//  CharacterSelectCell.swift
//  VFrames
//
//  Created by Andy Garron on 2/6/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class CharacterSelectCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var targetCharacter: CharacterID?
    
    func setTargetCharacter(targetCharacter: CharacterID!) {
        self.targetCharacter = targetCharacter
        setCharacterImage(targetCharacter)
        setCharacterName(targetCharacter)
    }
    
    private func setCharacterImage(characterId: CharacterID) {
        var imageName: String!

        switch(characterId) {
            case .ALEX:
                imageName = "alex_card"
            case .BIRDIE:
                imageName = "birdie_card"
            case .CAMMY:
                imageName = "cammy_card"
            case .CHUN:
                imageName = "chun_card"
            case .CLAW:
                imageName = "claw_card"
            case .DHALSIM:
                imageName = "dhalsim_card"
            case .DICTATOR:
                imageName = "dictator_card"
            case .FANG:
                imageName = "fang_card"
            case .GUILE:
                imageName = "guile_card"
            case .KARIN:
                imageName = "karin_card"
            case .KEN:
                imageName = "ken_card"
            case .LAURA:
                imageName = "laura_card"
            case .MIKA:
                imageName = "mika_card"
            case .NASH:
                imageName = "nash_card"
            case .NECALLI:
                imageName = "necalli_card"
            case .RASHID:
                imageName = "rashid_card"
            case .RYU:
                imageName = "ryu_card"
            case .ZANGIEF:
                imageName = "zangief_card"
        }
        
        characterImage.image = UIImage(named: imageName)
    }
    
    private func setCharacterName(characterId: CharacterID) {
        nameLabel.text = CharacterID.toString(characterId)
    }
    
}
