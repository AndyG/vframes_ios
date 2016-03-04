//
//  GetTwitchStreamsTask.swift
//  VFrames
//
//  Created by Andy Garron on 3/4/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

public class GetTwitchStreamsTask {
    
    private var data: NSData?
    
    public func getStreams(listener: GetTwitchStreamsListenerProtocol) {
        
        let urlString = "https://api.twitch.tv/kraken/streams?game=Street%20Fighter%20V"
        
        print("calling twitch url: \(urlString)")
        
        let url = NSURL(string: urlString)!
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
            self.processResponse(listener)
        }
        
        task.resume()
    }
    
    private func processResponse(listener: GetTwitchStreamsListenerProtocol) {
        var error: NSError?
        let jsonData = JSON(data: data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        if (error != nil) {
            listener.onError()
        } else {
            let twitchStreams = TwitchStreamsJsonAdapter.loadStreams(jsonData)
            listener.onResult(twitchStreams)
        }
    }
}