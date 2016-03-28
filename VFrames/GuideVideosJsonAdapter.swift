import Foundation
import SwiftyJSON

public class GuideVideosJsonAdapter {
    
    static func loadVideos(videosJson: [JSON]) -> Array<VideoPrtcl> {
        
        var guideVideos = Array<VideoPrtcl>()
        for videoJson in videosJson {
            print(videoJson)
            let videoId = videoJson["videoID"].string!
            let description = videoJson["desc"].string!
            let characterString = videoJson["character"].string!
            print("found character: " + characterString)
            
            let character: CharacterID? = CharacterID(rawValue: characterString)
            
            let video = GuideVideo(videoId: videoId, description: description, character: character)
            
            guideVideos.append(video)
        }
        
        return guideVideos
    }
}