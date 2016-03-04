//
//  GetTwitchStreamsListenerProtocol.swift
//  VFrames
//
//  Created by Andy Garron on 3/4/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public protocol GetTwitchStreamsListenerProtocol {
    func onResult(result: Array<TwitchStream>)
    func onError()
}