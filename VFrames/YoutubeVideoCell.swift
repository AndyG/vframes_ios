//
//  RecommendedVideosCellTableViewCell.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

public class YoutubeVideoCell: UITableViewCell {

    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var videoTitle: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var descriptionText: UILabel!
    
    public func setVideo(video: YoutubeVideo) {
        videoTitle.text = video.title
        author.text = video.author
        descriptionText.text = video.subtext
        
        loadImageForStream(video.thumbnailUrl)
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
