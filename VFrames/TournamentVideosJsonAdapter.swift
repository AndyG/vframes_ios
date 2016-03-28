//
//  TournamentVideosJsonAdapter.swift
//  VFrames
//
//  Created by Andy Garron on 3/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TournamentVideosJsonAdapter {
    static func loadVideos(videosJson: [JSON]) -> Array<VideoPrtcl> {
        
        var tournamentVideos = Array<VideoPrtcl>()
        for videoJson in videosJson {
            let videoId = videoJson["videoID"].string!
            let tournamentName = videoJson["tournamentName"].string!
            
            let video = TournamentVideo(videoId: videoId, tournamentName: tournamentName)
            
            tournamentVideos.append(video)
        }
        
        return tournamentVideos
    }
}