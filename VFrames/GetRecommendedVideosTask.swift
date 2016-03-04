//
//  GetVideosTask.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

public class GetRecommendedVideosTask {
    
    var data: NSData?
    
    func loadData(listener: GetVideosTaskListenerProtocol, character: String) {
        let urlString = "http://agarron.com/res/vframes/recommendedVideos/\(character)/videos.json"
        
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
            
            print("successful getVideos response")
            self.data = data
            self.processResponse(listener)
        }
        
        task.resume()
    }
    
    private func processResponse(listener: GetVideosTaskListenerProtocol) {
        var error: NSError?
        let jsonData = JSON(data: data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        if (error != nil) {
            listener.onError()
        }
        
        print("loaded recommended videos json: \(jsonData)")
        let recommendedVideos = RecommendedVideosJsonAdapter.loadVideos(jsonData["videos"].arrayValue)
        let getYoutubeVideosTask = GetYoutubeVideosTask(recommendedVideos: recommendedVideos)
        getYoutubeVideosTask.getYoutubeVideos(listener)
    }
    
}