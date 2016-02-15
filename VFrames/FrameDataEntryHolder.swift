//
//  FrameDataEntryHolder.swift
//  VFrames
//
//  Created by Andy Garron on 2/13/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public class FrameDataEntryHolder {
    
    var frameDataEntry: FrameDataEntryProtocol
    var alternateFrameDataEntry: FrameDataEntryProtocol?
    
    init(frameDataEntry: FrameDataEntryProtocol, alternateFrameDataEntry: FrameDataEntryProtocol?) {
        self.frameDataEntry = frameDataEntry
        self.alternateFrameDataEntry = alternateFrameDataEntry
    }
    
    public func hasAlternate() -> Bool {
        return (alternateFrameDataEntry != nil)
    }
    
    public func getFrameDataEntry() -> FrameDataEntryProtocol {
        return frameDataEntry
    }
    
    public func getAlternateFrameDataEntry() -> FrameDataEntryProtocol {
        return alternateFrameDataEntry!
    }
}