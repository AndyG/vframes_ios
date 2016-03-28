import Foundation

public class TournamentVideo: VideoPrtcl {
    var videoId: String!
    var tournamentName: String!
    
    init(videoId: String, tournamentName: String) {
        self.videoId = videoId
        self.tournamentName = tournamentName
    }
    
    public func getVideoId() -> String {
        return videoId
    }
    
    public func getSubtext() -> String {
        return tournamentName
    }
}