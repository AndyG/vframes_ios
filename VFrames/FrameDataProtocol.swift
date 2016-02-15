//
//  FrameDataProtocol.swift
//  VFrames
//
//  Created by Andy Garron on 2/13/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public protocol FrameDataProtocol {
    
    func hasCategory(category: MoveCategory) -> Bool
    
    func getFromCategory(category: MoveCategory) -> Array<FrameDataEntryHolder>
    
    func hasAlternateFrameData() -> Bool
    
}