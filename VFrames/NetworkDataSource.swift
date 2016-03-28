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
        let urlString = "http://still-hollows-20653.herokuapp.com/dataModel?endpoint=iOS"

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
        
        if (error != nil) {
            listener.onResult(.ERROR)
            return
        }
        
        //We know the version is new and supported.
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