//
//  JSONLoader.swift
//  VFrames
//
//  Created by Andy Garron on 2/15/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONLoader {
    static func loadJsonFile(fileName: String) -> JSON {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        let url = NSURL(fileURLWithPath: path!)
        let data = NSData(contentsOfURL: url)!
        var error: NSError?
        let jsonData = JSON(data: data, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        if (error != nil) {
            print("error!!")
            print("error: \(error!.localizedDescription)")
        } else {
            print("no error. jsonData is nil: \(jsonData == nil)")
        }
        
        return jsonData
    }
}