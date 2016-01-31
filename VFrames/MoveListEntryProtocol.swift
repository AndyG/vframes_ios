//
//  MoveListEntryProtocol.swift
//  VFrames
//
//  Created by Andy Garron on 1/30/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

protocol MoveListEntryProtocol {
    func getNameId() -> String
    func getInput() -> Array<InputElement>?
    func getPretextId() -> String?
    func getPosttextId() -> String?
    func getDescriptionId() -> String?
}