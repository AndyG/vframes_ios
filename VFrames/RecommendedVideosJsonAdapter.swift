//
//  RecommendedVideosJsonAdapter.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

public class RecommendedVideosJsonAdapter {
    
    static func loadVideos(videosJson: [JSON]) -> [String: Array<RecommendedVideo>] {
        
        var recommendedVideos = [String: Array<RecommendedVideo>]()
        
        for (categoryJsonContainer) in videosJson {
            for (category, categoryJson) in categoryJsonContainer {
        
                print("parsing category: \(category)")
                let videosForCategory = loadVideosForCategory(categoryJson)
                recommendedVideos[category] = videosForCategory
            }
        }
        
        return recommendedVideos
    }
    
    static private func loadVideosForCategory(jsonData: JSON) -> Array<RecommendedVideo> {

        var videosInCategory = Array<RecommendedVideo>()
        
        for videoJsonObject in jsonData {
            let videoJson = videoJsonObject.1
            let videoId = videoJson["videoID"].string!
            let description = videoJson["description"].string!
            
            videosInCategory.append(RecommendedVideo(videoId: videoId, description: description))
        }
        
        return videosInCategory
    }
}