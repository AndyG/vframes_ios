//
//  YoutubeVideo.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

public class YoutubeVideo {
    var title: String!
    var author: String!
    var thumbnailUrl: String!
    var description: String!
    var id: String!
    
    public init(title: String, author: String, thumbnailUrl: String, description: String, id: String) {
        self.title = title
        self.author = author
        self.thumbnailUrl = thumbnailUrl
        self.description = description
        self.id = id
    }
}