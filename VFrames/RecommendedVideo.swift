//
//  RecommendedVideo.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public class RecommendedVideo {
    var videoId: String!
    var description: String!
    
    init(videoId: String, description: String) {
        self.videoId = videoId
        self.description = description
    }
}