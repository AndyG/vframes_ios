import Foundation

public class GuideVideo: GuideVideoPrtcl {
    var videoId: String!
    var description: String!
    
    //If there is no character, it is a general guide
    var character: CharacterID?
    
    init(videoId: String, description: String, character: CharacterID?) {
        self.videoId = videoId
        self.description = description
        self.character = character
    }
    
    public func getVideoId() -> String {
        return videoId
    }
    
    public func getSubtext() -> String {
        return description
    }
    
    public func getCharacter() -> CharacterID? {
        return character
    }
}