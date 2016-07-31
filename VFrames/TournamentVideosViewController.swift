//
//  RecommendedVideosViewController.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class TournamentVideosController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, GetVideosTaskListenerProtocol {
    
    @IBOutlet var firstCharacterPicker: UIPickerView!
    @IBOutlet var secondCharacterPicker: UIPickerView!
    
    @IBOutlet var errorLoadingLayout: UIView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var videosTableView: UITableView!
    @IBOutlet var noVideosLabel: UILabel!
    
    var youtubeVideos: [YoutubeVideo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideos()
    }
    
    private func loadVideos() {
        showLoadingIndicator()
        
        let firstQueryParameter = getQueryParameter(firstCharacterPicker)
        let secondQueryParameter = getQueryParameter(secondCharacterPicker)
        let getTournamentVideosTask = GetTournamentVideosTask()
        getTournamentVideosTask.loadData(self, firstCharacter: firstQueryParameter, secondCharacter: secondQueryParameter)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let video = youtubeVideos[indexPath.item]
        
        let cell = videosTableView.dequeueReusableCellWithIdentifier("youtubeVideoCell")
        
        let youtubeVideoCell = cell as! YoutubeVideoCell
        youtubeVideoCell.setVideo(video)
        print("set video in cell")
        return youtubeVideoCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (youtubeVideos != nil) {
            return youtubeVideos.count
        } else {
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tournament Matches"
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let video = youtubeVideos[indexPath.row]
        let id = video.id
        let url = NSURL(string: "https://youtube.com/watch?v=\(id)")!
        UIApplication.sharedApplication().openURL(url)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //1 row for each character, then one for "general"
        return CharacterID.allValuesAlphabetic.count + 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (row == 0) {
            return "Any"
        } else {
            return CharacterID.toString(CharacterID.allValuesAlphabetic[row - 1])
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        loadVideos()
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
        case .GUILE:
            return "guile"
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
        case .IBUKI:
            return "ibuki"
        case .BOXER:
            return "boxer"
        case .JURI:
            return "juri"
        }
    }
    
    private func getQueryParameter(picker: UIPickerView) -> String {
        let row = picker.selectedRowInComponent(0)
        var selection = "any"
        if row != 0 {
            let character = CharacterID.allValuesAlphabetic[row - 1]
            selection = getCharacterStringForUrl(character)
        }
        return selection
    }
    
    private func showVideosTable(youtubeVideos: [YoutubeVideo]) {
        self.youtubeVideos = youtubeVideos
        videosTableView.reloadData()
        
        loadingIndicator.stopAnimating()
        loadingIndicator.hidden = true
        noVideosLabel.hidden = true
        errorLoadingLayout.hidden = true
        
        videosTableView.hidden = false
    }
    
    private func showNoVideosUI() {
        loadingIndicator.stopAnimating()
        loadingIndicator.hidden = true
        errorLoadingLayout.hidden = true
        videosTableView.hidden = true
        
        noVideosLabel.hidden = false
    }
    
    private func showErrorUI() {
        loadingIndicator.stopAnimating()
        loadingIndicator.hidden = true
        noVideosLabel.hidden = true
        videosTableView.hidden = true
        
        errorLoadingLayout.hidden = false
    }
    
    private func showLoadingIndicator() {
        noVideosLabel.hidden = true
        videosTableView.hidden = true
        errorLoadingLayout.hidden = true
        
        self.loadingIndicator.startAnimating()
        self.loadingIndicator.hidden = false
    }
    
    func onResult(result: [YoutubeVideo]) {
        print("got result with \(result.count) videos")
        dispatch_async(dispatch_get_main_queue(), {
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
