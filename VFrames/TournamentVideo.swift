import Foundation

public class TournamentVideo: TournamentVideoPrtcl {
    var videoId: String!
    var tournamentName: String!
    var firstCharacter: CharacterID!
    var secondCharacter: CharacterID!
    
    init(videoId: String, tournamentName: String, firstCharacter: CharacterID, secondCharacter: CharacterID) {
        self.videoId = videoId
        self.tournamentName = tournamentName
        self.firstCharacter = firstCharacter
        self.secondCharacter = secondCharacter
    }
    
    public func getVideoId() -> String {
        return videoId
    }
    
    public func getSubtext() -> String {
        return tournamentName
    }
    
    public func getFirstCharacter() -> CharacterID {
        return firstCharacter
    }
    
    public func getSecondCharacter() -> CharacterID {
        return secondCharacter
    }
}