//
//  TwitchStreamsJsonAdapter.swift
//  VFrames
//
//  Created by Andy Garron on 3/4/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TwitchStreamsJsonAdapter {
    public static func loadStreams(jsonObject: JSON) -> Array<TwitchStream> {
        
        var streams = Array<TwitchStream>()
        
        if let streamsJson = jsonObject["streams"].array {
            for streamJson in streamsJson {
                if let stream = parseStream(streamJson) {
                    streams.append(stream)
                }
            }
        }
        
        return streams
    }
    
    private static func parseStream(streamJson: JSON) -> TwitchStream? {
        var channelJson = streamJson["channel"]
        
        //Verify everything we need from the channel is there
        if (channelJson["display_name"] == nil || channelJson["url"] == nil) {
            return nil
        }
        
        //Get the channel data from the json.
        let channelDisplayName = channelJson["display_name"].string!
        let channelUrl = channelJson["url"].string!
        let status = channelJson["status"].string
        
        //Verify the stream has viewer count.
        if (streamJson["viewers"] == nil) {
            return nil
        }
        
        //Get the viewer count.
        let viewerCount = streamJson["viewers"].int!
        
        //Verify the stream has a preview.
        if (streamJson["preview"] == nil || streamJson["preview"]["medium"] == nil) {
            return nil
        }
        
        let previewUrl = streamJson["preview"]["medium"].string!
        
        return TwitchStream(channelDisplayName: channelDisplayName, status: status, channelUrl: channelUrl, viewerCount: viewerCount, previewUrl: previewUrl)
    }
}