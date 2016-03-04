//
//  CurrentStreamsViewController.swift
//  VFrames
//
//  Created by Andy Garron on 3/4/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class CurrentStreamsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GetTwitchStreamsListenerProtocol {

    @IBOutlet var errorContainerView: UIView!
    
    @IBOutlet var noStreamsLabel: UILabel!
    
    @IBOutlet var streamsTableView: UITableView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var twitchStreams: Array<TwitchStream>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the twitch streams.
        showLoadingIndicator()
        let getTwitchStreamsTask = GetTwitchStreamsTask()
        getTwitchStreamsTask.getStreams(self)
    }

    private func showLoadingIndicator() {
        dispatch_async(dispatch_get_main_queue(), {
            self.activityIndicator.startAnimating()
            self.activityIndicator.hidden = false
            
            self.errorContainerView.hidden = true
            self.streamsTableView.hidden = true
            self.noStreamsLabel.hidden = true
        })
    }
    
    private func showStreamsTable(streams: Array<TwitchStream>) {
        
        twitchStreams = streams
        
        dispatch_async(dispatch_get_main_queue(), {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            
            self.errorContainerView.hidden = true
            self.noStreamsLabel.hidden = true

            self.streamsTableView.reloadData()
            self.streamsTableView.hidden = false
        })
    }
    
    private func showNoStreamsUI() {
        dispatch_async(dispatch_get_main_queue(), {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            
            self.errorContainerView.hidden = true
            self.streamsTableView.hidden = true
            
            self.noStreamsLabel.hidden = false
        })
    }
    
    private func showErrorUI() {
        dispatch_async(dispatch_get_main_queue(), {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            

            self.streamsTableView.hidden = true
            self.noStreamsLabel.hidden = true
            
            self.errorContainerView.hidden = false
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("loading cell for row: \(indexPath.row)")
        let cell = tableView.dequeueReusableCellWithIdentifier("stream") as! TwitchStreamCell
        cell.setStream(twitchStreams[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (twitchStreams != nil) {
            return twitchStreams.count
        } else {
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (twitchStreams != nil) ? 1 : 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Live Streams"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let url = NSURL(string: twitchStreams[indexPath.row].channelUrl)!
        UIApplication.sharedApplication().openURL(url)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    //MARK: listener from network call
    func onResult(result: Array<TwitchStream>) {
        print("onResult")
        if (!result.isEmpty) {
            print("got \(result.count) streams")
            showStreamsTable(result)
        } else {
            showNoStreamsUI()
        }
    }
    
    func onError() {
        print("error")
        showErrorUI()
    }

}
