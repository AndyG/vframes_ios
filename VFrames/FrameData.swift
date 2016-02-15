//
//  FrameData.swift
//  VFrames
//
//  Created by Andy Garron on 2/13/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public class FrameData: FrameDataProtocol {
    
    private var categoriesDict: [MoveCategory : Array<FrameDataEntryHolder>]
    
    public init(categoriesDict: [MoveCategory : Array<FrameDataEntryHolder>]) {
        self.categoriesDict = categoriesDict
    }
    
    public func hasCategory(category: MoveCategory) -> Bool {
        return (categoriesDict[category] != nil)
    }
    
    public func getFromCategory(category: MoveCategory) -> Array<FrameDataEntryHolder> {
        return categoriesDict[category]!
    }
    
    public func hasAlternateFrameData() -> Bool {
        for (_, frameDataEntryHolders) in categoriesDict {
            for frameDataEntryHolder in frameDataEntryHolders {
                if frameDataEntryHolder.hasAlternate() {
                    return true
                }
            }
        }
        return false
    }
}