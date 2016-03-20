//
//  MoveListEntry.swift
//  VFrames
//
//  Created by Andy Garron on 1/30/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

class MoveListEntry: MoveListEntryProtocol {
    
    var name: String
    var pretext: String?
    var posttext: String?
    var description: String?
    var inputElementList: Array<InputElement>?
    
    init(name: String, pretext: String?, posttext: String?, description: String?, inputElementList: Array<InputElement>?) {
        self.name = name
        self.pretext = pretext
        self.posttext = posttext
        self.description = description
        self.inputElementList = inputElementList
    }

    func getName() -> String {
        return name
    }
    
    func getInput() -> Array<InputElement>? {
        return inputElementList
    }
    
    func getPretext() -> String? {
        return pretext
    }

    func getPosttext() -> String? {
        return posttext
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func getStringRepresentation() -> String {
        var stringRepresentation = String()
        
        stringRepresentation += "name: \(name)\n"
        
        if let unwrappedPretext = pretext {
            stringRepresentation += "pretext: \(unwrappedPretext)\n"
        }
        
        if let unwrappedPosttext = posttext {
            stringRepresentation += "posttext: \(unwrappedPosttext)\n"
        }
        
        if let unwrappedDescription = description {
            stringRepresentation += "description: \(unwrappedDescription)\n"
        }
        
        if let unwrappedInputElementList = inputElementList {
            stringRepresentation += "input: \(unwrappedInputElementList.description)\n"
        }
        
        return stringRepresentation
    }

}