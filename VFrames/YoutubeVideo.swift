import Foundation

public class YoutubeVideo {
    var title: String!
    var author: String!
    var thumbnailUrl: String!
    var subtext: String!
    var id: String!
    
    public init(title: String, author: String, thumbnailUrl: String, subtext: String, id: String) {
        self.title = title
        self.author = author
        self.thumbnailUrl = thumbnailUrl
        self.subtext = subtext
        self.id = id
    }
}