//
//  TwitchStream.swift
//  VFrames
//
//  Created by Andy Garron on 3/4/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public class TwitchStream {
    
    var channelDisplayName: String
    var status: String?
    var channelUrl: String
    var viewerCount: Int
    var previewUrl: String
    
    public init(channelDisplayName: String, status: String?, channelUrl: String, viewerCount: Int, previewUrl: String) {
        self.channelDisplayName = channelDisplayName
        self.status = status
        self.channelUrl = channelUrl
        self.viewerCount = viewerCount
        self.previewUrl = previewUrl
    }
    
}