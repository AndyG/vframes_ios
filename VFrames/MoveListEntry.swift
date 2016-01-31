//
//  MoveListEntry.swift
//  VFrames
//
//  Created by Andy Garron on 1/30/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

class MoveListEntry: MoveListEntryProtocol {
    
    var nameId: String
    var pretextId: String?
    var posttextId: String?
    var descriptionId: String?
    var inputElementList: Array<InputElement>?
    
    init(nameId: String, pretextId: String?, posttextId: String?, descriptionId: String?, inputElementList: Array<InputElement>?) {
        self.nameId = nameId
        self.pretextId = pretextId
        self.posttextId = posttextId
        self.descriptionId = descriptionId
        self.inputElementList = inputElementList
    }
    
    func getNameId() -> String {
        return nameId
    }
    
    func getInput() -> Array<InputElement>? {
        return inputElementList
    }
    
    func getPretextId() -> String? {
        return pretextId
    }
    
    func getPosttextId() -> String? {
        return posttextId
    }
    
    func getDescriptionId() -> String? {
        return descriptionId
    }
    
    func getStringRepresentation() -> String {
        var stringRepresentation = String()
        
        stringRepresentation += "name: \(nameId)\n"
        
        if let unwrappedPretextId = pretextId {
            stringRepresentation += "pretextId: \(unwrappedPretextId)\n"
        }
        
        if let unwrappedPosttextId = posttextId {
            stringRepresentation += "posttextId: \(unwrappedPosttextId)\n"
        }
        
        if let unwrappedDescriptionId = descriptionId {
            stringRepresentation += "descriptionId: \(unwrappedDescriptionId)\n"
        }
        
        if let unwrappedInputElementList = inputElementList {
            stringRepresentation += "input: \(unwrappedInputElementList.description)\n"
        }
        
        return stringRepresentation
    }

}