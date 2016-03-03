//
//  BnbsLoader.swift
//  VFrames
//
//  Created by Andy Garron on 3/2/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

public class BnbsLoader {
    
    static func loadCombos(jsonData: [JSON]) -> BreadAndButterModel {
        var breadAndButters = [String: Array<BreadAndButterCombo>]()
        
        for (categoryJsonContainer) in jsonData {

            for (category, categoryJson) in categoryJsonContainer {
                print("parsing category: \(category)")
                let combosForCategory = loadCombosFromCategory(categoryJson)
                breadAndButters[category] = combosForCategory
            }
        }
        
        return BreadAndButterModel(breadAndButters: breadAndButters)
    }
    
    private static func loadCombosFromCategory(jsonData: JSON) -> Array<BreadAndButterCombo> {
        var comboArray = Array<BreadAndButterCombo>()
        for comboJson in jsonData {
            let jsonObject = comboJson.1
            let comboLabel = jsonObject["label"].string!
            let comboInputs = jsonObject["inputs"].string!
            let comboDescription = jsonObject["description"].string!
            comboArray.append(BreadAndButterCombo(label: comboLabel, inputs: comboInputs, description: comboDescription))
        }
        
        return comboArray
    }

}