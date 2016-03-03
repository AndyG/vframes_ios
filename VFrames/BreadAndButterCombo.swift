//
//  BreadAndButterCombo.swift
//  VFrames
//
//  Created by Andy Garron on 3/2/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public class BreadAndButterCombo {
    
    private var bnbLabel : String!
    private var bnbInputs : String!
    private var bnbDescription : String!
    
    init(label: String, inputs: String, description: String) {
        bnbLabel = label
        bnbInputs = inputs
        bnbDescription = description
    }
    
    public func getLabel() -> String {
        return bnbLabel
    }
    
    public func getInputs() -> String {
        return bnbInputs
    }
    
    public func getDescription() -> String {
        return bnbDescription
    }
    
}