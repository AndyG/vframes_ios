//
//  RecommendedVideosViewController.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class GuideVideosController: UIViewController, UITableViewDataSource, UITableViewDelegate, GetVideosTaskListenerProtocol {
    
    @IBOutlet var errorLoadingContainer: UIView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var videosTableView: UITableView!
    @IBOutlet var noVideosLabel: UILabel!
    
    var targetCharacterId: CharacterID!
    
    var youtubeVideos: [String:Array<YoutubeVideo>]!
    var tableHeaders: Array<String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        videosTableView.hidden = true
        let getVideosTask = GetGuideVideosTask()
        getVideosTask.loadData(self, character: getCharacterStringForUrl(targetCharacterId))
        loadingIndicator.hidden = false
        loadingIndicator.startAnimating()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let category = tableHeaders[indexPath.section]
        let video = youtubeVideos[category]![indexPath.item]
        
        let cell = videosTableView.dequeueReusableCellWithIdentifier("youtubeVideoCell")
        
        let youtubeVideoCell = cell as! YoutubeVideoCell
        youtubeVideoCell.setVideo(video)
        return youtubeVideoCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableHeaders != nil) {
            let category = tableHeaders[section]
            return youtubeVideos[category]!.count
        } else {
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (tableHeaders != nil) {
            return tableHeaders.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (tableHeaders != nil) {
            return tableHeaders[section]
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let category = tableHeaders[indexPath.section]
        let video = youtubeVideos[category]![indexPath.item]
        let id = video.id
        let url = NSURL(string: "https://youtube.com/watch?v=\(id)")!
        UIApplication.sharedApplication().openURL(url)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    private func getCharacterStringForUrl(characterId: CharacterID) -> String {
        switch(characterId) {
        case .ALEX:
            return "alex"
        case .BIRDIE:
            return "birdie"
        case .CAMMY:
            return "cammy"
        case .CHUN:
            return "chun"
        case .CLAW:
            return "claw"
        case .DHALSIM:
            return "dhalsim"
        case .DICTATOR:
            return "dictator"
        case .FANG:
            return "fang"
        case .KARIN:
            return "karin"
        case .KEN:
            return "ken"
        case .LAURA:
            return "laura"
        case .MIKA:
            return "mika"
        case .NASH:
            return "nash"
        case .NECALLI:
            return "necalli"
        case .RASHID:
            return "rashid"
        case .RYU:
            return "ryu"
        case .ZANGIEF:
            return "zangief"
        }
    }
    
    private func setupTableHeaders() {
        tableHeaders = Array<String>()
        for category in youtubeVideos.keys {
            tableHeaders.append(category)
        }
    }
    
    private func showVideosTable(youtubeVideos: [String:Array<YoutubeVideo>]) {
        videosTableView.hidden = false
        self.youtubeVideos = youtubeVideos
        setupTableHeaders()
        videosTableView.reloadData()
        
        errorLoadingContainer.hidden = true
        videosTableView.hidden = false
    }
    
    private func showNoVideosUI() {
        noVideosLabel.hidden = false
        errorLoadingContainer.hidden = true
        videosTableView.hidden = true
    }
    
    private func showErrorUI() {
        loadingIndicator.stopAnimating()
        loadingIndicator.hidden = true
        noVideosLabel.hidden = true
        videosTableView.hidden = true
        errorLoadingContainer.hidden = false
    }
    
    func onResult(result: [String:Array<YoutubeVideo>]) {
        dispatch_async(dispatch_get_main_queue(), {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.hidden = true
            
            if (!result.isEmpty) {
                self.showVideosTable(result)
            } else {
                self.showNoVideosUI()
            }
        })
        
    }
    
    func onError() {
        dispatch_async(dispatch_get_main_queue(), {
            self.showErrorUI()
        })
    }
}
