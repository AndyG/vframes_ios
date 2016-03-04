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
    
    private func showStreamsTable() {
        dispatch_async(dispatch_get_main_queue(), {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            
            self.errorContainerView.hidden = true
            self.noStreamsLabel.hidden = true
            
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
        let cell = tableView.dequeueReusableCellWithIdentifier("streamCell")!
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func onResult(result: Array<TwitchStream>) {
        print("onResult")
        if (!result.isEmpty) {
            showStreamsTable()
        } else {
            showNoStreamsUI()
        }
    }
    
    func onError() {
        print("error")
        showErrorUI()
    }

}
