//
//  HardCodedFrameDataEntry.swift
//  VFrames
//
//  Created by Andy Garron on 2/13/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public class HardCodedFrameDataEntry: FrameDataEntryProtocol {
    
    var displayName: String!
    
    var startupFrames: Int!
    var activeFrames: Int!
    var recoveryFrames: Int!
    var blockAdvantage: Int!
    var hitAdvantage: Int!
    
    var damageValue: Int!
    var stunValue: Int!
    
    var descriptionId: String?
    
    public init (displayName: String, startupFrames: Int, activeFrames: Int, recoveryFrames: Int, blockAdvantage: Int, hitAdvantage: Int, damageValue: Int, stunValue: Int, descriptionId: String?) {
        self.displayName = displayName;
        
        self.startupFrames = startupFrames;
        self.activeFrames = activeFrames;
        self.recoveryFrames = recoveryFrames;
        self.blockAdvantage = blockAdvantage;
        self.hitAdvantage = hitAdvantage;
        
        self.damageValue = damageValue;
        self.stunValue = stunValue;
        
        self.descriptionId = descriptionId;
    }
    
    
    public func getDisplayName() -> String {
        return displayName
    }
    
    public func getStartupFrames() -> Int {
        return startupFrames
    }
    
    public func getActiveFrames() -> Int {
        return activeFrames
    }
    
    public func getRecoveryFrames() -> Int {
        return recoveryFrames
    }
    
    public func getBlockAdvantage() -> Int {
        return blockAdvantage
    }
    
    public func getHitAdvantage() -> Int {
        return hitAdvantage
    }
    
    public func getDamageValue() -> Int {
        return damageValue
    }
    
    public func getStunValue() -> Int {
        return stunValue
    }
    
    public func getDescriptionId() -> String? {
        return descriptionId
    }
}