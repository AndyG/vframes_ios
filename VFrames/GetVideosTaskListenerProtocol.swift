//
//  GetVideosTaskListenerProtocol.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public protocol GetVideosTaskListenerProtocol {
    func onResult(result: [String:Array<YoutubeVideo>])
    func onError()
}