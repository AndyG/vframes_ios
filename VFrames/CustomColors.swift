//
//  CustomColors.swift
//  VFrames
//
//  Created by Andy Garron on 2/13/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

extension UIColor {
    
    func guilePrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x112804)
    }
    
    func chunPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x5b58c7)
    }
    
    func alexPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0xb41515)
    }
    
    func birdiePrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x33261f)
    }
    
    func ryuPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x355547)
    }
    
    func dhalsimPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0xa1141c)
    }
    
    func cammyPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x1a540a)
    }
    
    func kenPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0xc11e10)
    }
    
    func clawPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x600100)
    }

    func dictatorPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x4e2494)
    }
    
    func lauraPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x205e1f)
    }
    
    func mikaPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x0e7a82)
    }
    
    func fangPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x260793)
    }
    
    func karinPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x0c81b1)
    }
    
    func necalliPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x56284b)
    }
    
    func nashPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x2f4419)
    }
    
    func zangiefPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x515b53)
    }
    
    func rashidPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x63291a)
    }
    
    func ibukiPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x301c00)
    }
    
    func boxerPrimary() -> UIColor {
        return ColorUtils.UIColorFromRGB(0x041173)
    }
    
    func highlightedFrameDataEntryColor() -> UIColor {
        return ColorUtils.UIColorFromRGB(0xffebeb)
    }
    
    func getPrimaryColorForCharacter(characterId: CharacterID) -> UIColor {
        switch(characterId) {
        case .ALEX:
            return alexPrimary()
            case .BIRDIE:
                return birdiePrimary()
            case .CAMMY:
                return cammyPrimary()
            case .CHUN:
                return chunPrimary()
            case .CLAW:
                return clawPrimary()
            case .DHALSIM:
                return dhalsimPrimary()
            case .DICTATOR:
                return dictatorPrimary()
            case .FANG:
                return fangPrimary()
            case .GUILE:
                return guilePrimary()
            case .KARIN:
                return karinPrimary()
            case .KEN:
                return kenPrimary()
            case .LAURA:
                return lauraPrimary()
            case .MIKA:
                return mikaPrimary()
            case .NASH:
                return nashPrimary()
            case .NECALLI:
                return necalliPrimary()
            case .RASHID:
                return rashidPrimary()
            case .RYU:
                return ryuPrimary()
            case .ZANGIEF:
                return zangiefPrimary()
            case .IBUKI:
                return ibukiPrimary()
            case .BOXER:
                return boxerPrimary()
        }
    }
    
}