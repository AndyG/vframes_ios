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
        
        incrementLaunchCount()
        incrementVersionLaunchCount()
        
        initializeSupportDirectory()
        
        //We don't want to try to load a saved model if the model doesn't exist or
        //if this is the user's first time launching this version of the app.
        if (isFirstVersionLaunch() || !savedCharactersModelExists()) {
            print("loading default")
            loadDefaultCharactersModel()
        } else {
            print("loading saved")
            loadSavedCharactersModel()
        }
        
        return true
    }

    func getCharactersModel() -> CharactersModel {
        return charactersModel
    }
    
    func setCharactersModel(charactersModel: CharactersModel) {
        self.charactersModel = charactersModel
    }
    
    func reloadCharactersModel() {
        initializeSupportDirectory()
        if savedCharactersModelExists() {
            loadSavedCharactersModel()
        } else {
            loadDefaultCharactersModel()
        }
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
        let path = NSBundle.mainBundle().pathForResource("default_data_model", ofType: "json")
        let defaultModelUrl = NSURL(fileURLWithPath: path!)
        
        //Copy file to app support directory so it's there next time
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
        if let applicationSupportURL = urls.last {
            let charactersModelURL = applicationSupportURL.URLByAppendingPathComponent("characters_model.json")
            do {
                try fileManager.copyItemAtURL(defaultModelUrl, toURL: charactersModelURL)
            } catch let error as NSError {
                if error.code == NSFileWriteFileExistsError {
                    print("removing old file")
                    removeFileAtUrl(charactersModelURL)
                    try! fileManager.copyItemAtURL(defaultModelUrl, toURL: charactersModelURL)
                }
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
    
    private func incrementLaunchCount() {
        let launchCountKey = "PREFS_LAUNCH_COUNT_KEY"
        let prefs = NSUserDefaults.standardUserDefaults()
        var launchCount = prefs.integerForKey(launchCountKey)
        launchCount++
        prefs.setInteger(launchCount, forKey: launchCountKey)
    }
    
    private func incrementVersionLaunchCount() {
        let appVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        let versionLaunchCountKey = "PREFS_LAUNCH_COUNT_KEY_VERSION_\(appVersion)"
        
        let prefs = NSUserDefaults.standardUserDefaults()
        var launchCount = prefs.integerForKey(versionLaunchCountKey)
        launchCount++
        prefs.setInteger(launchCount, forKey: versionLaunchCountKey)
    }
    
    private func isFirstVersionLaunch() -> Bool {
        let appVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        let versionLaunchCountKey = "PREFS_LAUNCH_COUNT_KEY_VERSION_\(appVersion)"
        
        let prefs = NSUserDefaults.standardUserDefaults()
        return (prefs.integerForKey(versionLaunchCountKey) == 1)
    }
    
    private func removeFileAtUrl(url: NSURL) {
        do {
            let fileManager = NSFileManager.defaultManager()
            try! fileManager.removeItemAtURL(url)
        }
    }
    
}

