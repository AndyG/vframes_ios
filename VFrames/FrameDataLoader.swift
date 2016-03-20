//
//  FrameDataLoader.swift
//  VFrames
//
//  Created by Andy Garron on 2/13/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

public class FrameDataLoader {
    
    private static var DISPLAY_CODE_MISSING_VALUE = 1001
    
    public static func loadFrameData(frameDataJson: JSON) -> FrameDataProtocol {
        var categoriesDict = [MoveCategory : Array<FrameDataEntryHolder>]()
        for (key, subJson) in frameDataJson {
            let category: MoveCategory = MoveCategory(rawValue: key)!
            let frameDataInCategory = loadFrameDataInCategory(subJson)
            categoriesDict[category] = frameDataInCategory
        }
        
        return FrameData(categoriesDict: categoriesDict)
    }
    
    private static func loadFrameDataInCategory(categoryJson: JSON) -> Array<FrameDataEntryHolder> {
        var frameDataArray = Array<FrameDataEntryHolder>()
        for (_, subJson) in categoryJson {
            frameDataArray.append(loadSingleFrameDataEntry(subJson))
        }
        return frameDataArray
    }
    
    private static func loadSingleFrameDataEntry(frameDataEntryJson: JSON) -> FrameDataEntryHolder {
        //TODO: load other types of moves
        return loadHardCodedFrameDataEntryHolder(frameDataEntryJson)
    }
    
    private static func loadHardCodedFrameDataEntryHolder(frameDataEntryJson: JSON) -> FrameDataEntryHolder {
        let name = frameDataEntryJson["name"].string!
        let description = frameDataEntryJson["description"].string
        
        let frameData = loadHardCodedFrameDataEntry(name, description: description, frameDataEntryJson: frameDataEntryJson["data"])
        
        var alternateFrameData: FrameDataEntryProtocol?
        if (frameDataEntryJson["alternateData"] != nil) {
            alternateFrameData = loadHardCodedFrameDataEntry(name, description: description, frameDataEntryJson: frameDataEntryJson["alternateData"])
        }
        
        return FrameDataEntryHolder(frameDataEntry: frameData, alternateFrameDataEntry: alternateFrameData)
    }
    
    private static func loadHardCodedFrameDataEntry(name: String, description: String?, frameDataEntryJson: JSON) -> FrameDataEntryProtocol {
        
        var startupFrames = DISPLAY_CODE_MISSING_VALUE;
        var activeFrames = DISPLAY_CODE_MISSING_VALUE;
        var recoveryFrames = DISPLAY_CODE_MISSING_VALUE;
        var blockAdvantage = DISPLAY_CODE_MISSING_VALUE;
        var hitAdvantage = DISPLAY_CODE_MISSING_VALUE;
        var damageValue = DISPLAY_CODE_MISSING_VALUE;
        var stunValue = DISPLAY_CODE_MISSING_VALUE;
        
        if let startupFramesFromJson = frameDataEntryJson["startupFrames"].int {
            startupFrames = startupFramesFromJson
        }
        
        if let activeFramesFromJson = frameDataEntryJson["activeFrames"].int {
            activeFrames = activeFramesFromJson
        }
        
        if let recoveryFramesFromJson = frameDataEntryJson["recoveryFrames"].int {
            recoveryFrames = recoveryFramesFromJson
        }
        
        if let blockAdvantageFromJson = frameDataEntryJson["blockAdvantage"].int {
            blockAdvantage = blockAdvantageFromJson
        }
        
        if let hitAdvantageFromJson = frameDataEntryJson["hitAdvantage"].int {
            hitAdvantage = hitAdvantageFromJson
        }
   
        if let damageValueFromJson = frameDataEntryJson["damageValue"].int {
            damageValue = damageValueFromJson
        }
        
        if let stunValueFromJson = frameDataEntryJson["stunValue"].int {
            stunValue = stunValueFromJson
        }
        
        var overrideDescription: String? = description
        if let descriptionFromJson = frameDataEntryJson["description"].string {
            overrideDescription = descriptionFromJson
        }
        
        return HardCodedFrameDataEntry(displayName: name, startupFrames: startupFrames, activeFrames: activeFrames, recoveryFrames: recoveryFrames, blockAdvantage: blockAdvantage, hitAdvantage: hitAdvantage, damageValue: damageValue, stunValue: stunValue, description: overrideDescription)
    }
}