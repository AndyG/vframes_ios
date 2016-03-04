//
//  TwitchStreamCell.swift
//  VFrames
//
//  Created by Andy Garron on 3/4/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

public class TwitchStreamCell: UITableViewCell {

    @IBOutlet var channelName: UILabel!
    @IBOutlet var viewCount: UILabel!
    @IBOutlet var status: UILabel!

    public func setStream(stream: TwitchStream) {
        channelName.text = stream.channelDisplayName
        viewCount.text = String(stream.viewerCount)
        status.text = stream.status
    }
}
