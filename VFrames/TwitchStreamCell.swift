//
//  TwitchStreamCell.swift
//  VFrames
//
//  Created by Andy Garron on 3/4/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

public class TwitchStreamCell: UITableViewCell {

    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var channelName: UILabel!
    @IBOutlet var viewCount: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var thumbnailImage: UIImageView!

    public func setStream(stream: TwitchStream) {
        channelName.text = stream.channelDisplayName
        viewCount.text = "\(stream.viewerCount) viewers"
        status.text = stream.status

        loadImageForStream(stream.previewUrl)
    }
    
    private func loadImageForStream(url: String) {
        
        loadingIndicator.hidden = false
        loadingIndicator.startAnimating()
        
        let httpsUrl = NSURL(string: forceHttps(url))!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(httpsUrl) {
            (data, response, error) in
            guard let _:NSData = data, let _: NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            let image = UIImage(data: data!)
            self.setThumbnailImage(image!)
        }
        
        task.resume()
    }
    
    private func setThumbnailImage(image: UIImage) {
        dispatch_async(dispatch_get_main_queue(), {
            self.loadingIndicator.stopAnimating()
            self.thumbnailImage.image = image
        })
    }
    
    private func forceHttps(url: String) -> String {
        if (!url.containsString("https")) {
            let httpsUrl = url.stringByReplacingOccurrencesOfString("http", withString: "https")
            return httpsUrl
        } else {
            return url
        }
    }
    
}
