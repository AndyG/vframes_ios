//
//  AppDelegate.swift
//  VFrames
//
//  Created by Andy Garron aka on 1/27/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var charactersModel: CharactersModel!
    var charactersModelVersion: Int!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Fabric.with([Crashlytics.self])
        StringResolver.initialize()
        
        initializeSupportDirectory()
        if savedCharactersModelExists() {
            loadSavedCharactersModel()
        } else {
            loadDefaultCharactersModel()
        }
        NetworkDataSource().loadData()
        return true
    }

    func getCharactersModel() -> CharactersModel {
        return charactersModel
    }
    
    private func initializeSupportDirectory() {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
        if let applicationSupportURL = urls.last {
            do {
                if (!(fileManager.fileExistsAtPath(applicationSupportURL.relativePath!))) {
                    try fileManager.createDirectoryAtURL(applicationSupportURL, withIntermediateDirectories: true, attributes: nil)
                    print("initialized support directory")
                }
            } catch {
                print("failed to initialize support directory")
            }
            
        }
    }
    
    private func savedCharactersModelExists() -> Bool {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
        if let applicationSupportURL = urls.last {
            let versionFileURL = applicationSupportURL.URLByAppendingPathComponent("characters_model.json")
            if fileManager.fileExistsAtPath(versionFileURL.relativePath!) {
                print("found saved characters model")
                return true
            } else {
                print("could not find saved characters model")
                return false
            }
        } else {
            print("could not find app support directory")
            return false
        }
    }
    
    private func loadSavedCharactersModel() {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
        if let applicationSupportURL = urls.last {
            let savedCharactersModelURL = applicationSupportURL.URLByAppendingPathComponent("characters_model.json")
            loadCharactersModelFromUrl(savedCharactersModelURL)
            print("loaded saved characters model")
        }
    }
    
    private func loadDefaultCharactersModel() {
        let path = NSBundle.mainBundle().pathForResource("default_characters_model", ofType: "json")
        let defaultModelUrl = NSURL(fileURLWithPath: path!)
        
        //Copy file to app support directory so it's there next time
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
        if let applicationSupportURL = urls.last {
            let charactersModelURL = applicationSupportURL.URLByAppendingPathComponent("characters_model.json")
            do {
                try fileManager.copyItemAtURL(defaultModelUrl, toURL: charactersModelURL)
            } catch {
                print("failed to copy characters model file")
                print("from: \(defaultModelUrl.absoluteString)")
                print("to: \(charactersModelURL.absoluteString)")
            }
        }
        
        loadCharactersModelFromUrl(defaultModelUrl)
    }
    
    private func loadCharactersModelFromUrl(url: NSURL) {
        let data = NSData(contentsOfURL: url)!
        var error: NSError?
        let jsonData = JSON(data: data, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        if (error != nil) {
            print("error: \(error!.localizedDescription)")
        }
        
        let dataSource = CharactersModelJsonAdapter()
        charactersModel = dataSource.loadCharactersModel(jsonData)
        print("Loaded characters model version: \(charactersModel.getVersion())")
    }
    
}

