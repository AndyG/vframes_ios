//
//  RecommendedVideosCellTableViewCell.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

public class YoutubeVideoCell: UITableViewCell {

    @IBOutlet var videoTitle: UILabel!
    @IBOutlet var author: UILabel!
    @IBOutlet var descriptionText: UILabel!
    
    public func setVideo(video: YoutubeVideo) {
        videoTitle.text = video.title
        videoTitle.sizeToFit()
        
        author.text = video.author
        author.sizeToFit()
        
        descriptionText.text = video.description
        descriptionText.sizeToFit()
    }

}
