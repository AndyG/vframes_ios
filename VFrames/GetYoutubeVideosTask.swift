//
//  GetYoutubeVideosTask.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

public class GetYoutubeVideosTask {
    
    var data: NSData?
    
    public func getYoutubeVideos(videos: Array<VideoPrtcl>, listener: GetVideosTaskListenerProtocol) {
        
        let commaSeparatedVideoIds = getCommaSeparatedIds(videos)
        let idsToVideos = createIdsToVideosDict(videos)
        
        let urlString = "https://www.googleapis.com/youtube/v3/videos?key=AIzaSyBP5y-qxNYYBUjOPHXQxaVhzG4YqY6tVPM&part=snippet&id=\(commaSeparatedVideoIds)"
        
        let url:NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _: NSURLResponse = response  where error == nil else {
                print("error")
                listener.onError()
                return
            }
            
            self.data = data
            self.processResponse(videos, idsToVideos: idsToVideos, listener: listener)
        }
        
        task.resume()
    }
    
    private func processResponse(videos: [VideoPrtcl], idsToVideos: [String:VideoPrtcl], listener: GetVideosTaskListenerProtocol) {
        var error: NSError?
        let jsonData = JSON(data: data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        if (error != nil) {
            listener.onError()
        }
                
        var videosToReturn = [YoutubeVideo]()
        
        let idsToVideosDict = createIdsToVideosDict(videos)
        
        let videosJsonArray = jsonData["items"].arrayValue
        
        for videoJson in videosJsonArray {
            
            let videoId = videoJson["id"].string!
            
            //Get the rest of the information out of the JSON
            let snippet = videoJson["snippet"]
            let title = snippet["title"].string!
            let thumbnailUrl = snippet["thumbnails"]["medium"]["url"].string!
            let channelTitle = snippet["channelTitle"].string!
            
            var subtext = ""
            if let videoWithId = idsToVideosDict[videoId] {
                subtext = videoWithId.getSubtext()
            }
            
            let video = YoutubeVideo(title: title, author: channelTitle, thumbnailUrl: thumbnailUrl, subtext: subtext, id: videoId)
            videosToReturn.append(video)
            
        }
        
        listener.onResult(videosToReturn)
    }
    
    private func getCommaSeparatedIds(videos: [VideoPrtcl]) -> String {
        var ids = Array<String>()

        for video in videos {
            ids.append(video.getVideoId())
        }
        
        var commaSeparatedIds = String()
        
        for i in 0..<ids.count {
            commaSeparatedIds.appendContentsOf(ids[i])
            if (i != ids.count - 1) {
                commaSeparatedIds.appendContentsOf(",")
            }
        }
        
        return commaSeparatedIds
    }
    
    private func createIdsToVideosDict(videos: Array<VideoPrtcl>) -> [String:VideoPrtcl] {
        var dict = [String:VideoPrtcl]()
        for video in videos {
            dict[video.getVideoId()] = video
        }
        
        return dict
    }
    
}