//
//  GetTournamentVideosTask.swift
//  VFrames
//
//  Created by Andy Garron on 3/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

public class GetTournamentVideosTask {
    
    var data: NSData?
    
    func loadData(listener: GetVideosTaskListenerProtocol, firstCharacter: String, secondCharacter: String) {
 
        var urlString = ""
        if (firstCharacter != "any" && secondCharacter != "any") {
            urlString = "http://still-hollows-20653.herokuapp.com/tournamentVideosMatchup"
            urlString += "?firstCharacter=\(firstCharacter)&secondCharacter=\(secondCharacter)"
        } else if (firstCharacter != "any") {
            urlString = "http://still-hollows-20653.herokuapp.com/tournamentVideos"
            urlString += "?character=\(firstCharacter)"
        } else if (secondCharacter != "any") {
            urlString = "http://still-hollows-20653.herokuapp.com/tournamentVideos"
            urlString += "?character=\(secondCharacter)"
        } else {
            urlString = "http://still-hollows-20653.herokuapp.com/tournamentVideos"
        }
        
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
        
        let tournamentVideos = TournamentVideosJsonAdapter.loadVideos(jsonData.arrayValue)
        let getYoutubeVideosTask = GetYoutubeVideosTask()
        getYoutubeVideosTask.getYoutubeVideos(tournamentVideos, listener: listener)
    }

}