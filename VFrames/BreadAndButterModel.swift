//
//  BreadAndButterModel.swift
//  VFrames
//
//  Created by Andy Garron on 3/2/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public class BreadAndButterModel {
    
    var breadAndButters : [String: Array<BreadAndButterCombo>]!
    
    init(breadAndButters: [String: Array<BreadAndButterCombo>]) {
        self.breadAndButters = breadAndButters
    }
    
    public func getCategories() -> Array<String> {
        var categories = Array<String>()
        for (category, _) in breadAndButters {
            categories.append(category)
        }
        return categories
    }
    
    public func getCombosForCategory(category: String) -> Array<BreadAndButterCombo> {
        return breadAndButters[category]!
    }
    
}