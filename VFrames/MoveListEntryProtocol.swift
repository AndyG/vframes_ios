//
//  MoveListEntryProtocol.swift
//  VFrames
//
//  Created by Andy Garron on 1/30/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

protocol MoveListEntryProtocol {
    func getName() -> String
    func getInput() -> Array<InputElement>?
    func getPretext() -> String?
    func getPosttext() -> String?
    func getDescription() -> String?
}