//
//  NetworkDataSource.swift
//  VFrames
//
//  Created by Andy Garron on 2/14/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkDataSource {
    
    var data: NSData?
    
    func loadData(listener: NetworkDataSourceListenerProtocol, currentVersion: Int) {
        let appVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        let urlString = "http://agarron.com/res/vframes/ios/v\(appVersion)/characters_model.json"

        let url:NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _: NSURLResponse = response  where error == nil else {
                print("error")
                listener.onResult(GetNetworkDataResult.ERROR)
                return
            }
            
            print("successful response")
            self.data = data
            self.processResponse(listener, currentVersion: currentVersion)
        }
        
        task.resume()
    }
    
    private func processResponse(listener: NetworkDataSourceListenerProtocol, currentVersion: Int) {
        var error: NSError?
        print("\(data == nil)")
        let jsonData = JSON(data: data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        //check if the client version is supported
        if  jsonData["error"].string != nil {
            listener.onResult(GetNetworkDataResult.UNSUPPORTED)
            return
        }
        
        //check if the data from network is newer than current version
        if let version = Int(jsonData["version"].string!) {
            if (version <= currentVersion) {
                listener.onResult(GetNetworkDataResult.ALREADY_UP_TO_DATE)
                return
            }
        } else {
            listener.onResult(GetNetworkDataResult.ERROR)
            return
        }
        
        //Now we know the version is new and supported!
        //Need to save it as the new character model in app support and
        //refresh the existing instance of the app
        let newCharactersModel = CharactersModelJsonAdapter().loadCharactersModel(jsonData)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.setCharactersModel(newCharactersModel)
        AppSupportUtil().writeNewCharactersModel(data!)
        
        //Let the listener know that the update is done so it can reload its data
        listener.onResult(GetNetworkDataResult.UPDATED)
    }

}