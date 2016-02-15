//
//  AppSupportUtil.swift
//  VFrames
//
//  Created by Andy Garron on 2/15/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import Foundation

class AppSupportUtil {
    
    func writeNewCharactersModel(data: NSData) {
        let fileManager = NSFileManager.defaultManager()
        do {
            let charactersModelUrl = try getCharactersModelUrl()
            fileManager.createFileAtPath(charactersModelUrl.relativePath!, contents: data, attributes: nil)
            print("successfully wrote characters model file")
        } catch {
            print("failed to write characters model file")
        }
    }
    
    func clearData() {
        let fileManager = NSFileManager.defaultManager()
        do {
            let charactersModelUrl = try getCharactersModelUrl()
            try fileManager.removeItemAtURL(charactersModelUrl)
            print("successfully deleted characters model file")
        } catch {
            print("failed to delete characters model file")
        }
    }
    
    private func getCharactersModelUrl() throws -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
        if let applicationSupportURL = urls.last {
            return  applicationSupportURL.URLByAppendingPathComponent("characters_model.json")
        } else {
            throw NSURLError.BadURL
        }
    }
}