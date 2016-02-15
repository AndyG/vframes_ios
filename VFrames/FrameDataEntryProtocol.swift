//
//  FrameDataEntryProtocol.swift
//  VFrames
//
//  Created by Andy Garron on 2/13/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public protocol FrameDataEntryProtocol {
    func getDisplayName() -> String
    
    func getStartupFrames() -> Int
    func getActiveFrames() -> Int
    func getRecoveryFrames() -> Int
    
    func getBlockAdvantage() -> Int
    func getHitAdvantage() -> Int
    
    func getDamageValue() -> Int
    func getStunValue() -> Int
    
    func getDescriptionId() -> String?
}