//
//  GetDataVersionTaskListener.swift
//  VFrames
//
//  Created by Andy Garron on 3/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public protocol GetDataVersionTaskListener {
    func onUpToDate()
    func onNewDataAvailable()
    func onVersionOutOfDate()
    func onError()
}