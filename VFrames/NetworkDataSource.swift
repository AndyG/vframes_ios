//
//  NetworkDataSource.swift
//  VFrames
//
//  Created by Andy Garron on 2/14/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

class NetworkDataSource {
    
    func loadData() {
        let appVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        print("App Version: \(appVersion)")
    }
}