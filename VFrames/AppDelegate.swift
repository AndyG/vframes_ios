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
                try fileManager.createDirectoryAtURL(applicationSupportURL, withIntermediateDirectories: true, attributes: nil)
                print("initialized support directory")
            } catch {
                print("failed to initialize support directory")
            }
            
        }
    }
    
    private func savedCharactersModelExists() -> Bool {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
        if let applicationSupportURL = urls.last {
            let versionFileURL = applicationSupportURL.URLByAppendingPathComponent("characters_model_version.json")
            if fileManager.fileExistsAtPath(versionFileURL.absoluteString) {
                print("file existed at \(versionFileURL.absoluteString)")
                return true
            } else {
                print("no file existed at \(versionFileURL.absoluteString)")
                return false
            }
        } else {
            print("could not find app support directory")
            return false
        }
    }
    
    private func loadSavedCharactersModel() {
        
    }
    
    private func loadDefaultCharactersModel() {
        loadDefaultCharactersModelData()
    }
    
    private func loadDefaultCharactersModelData() {
        let jsonFilePath:NSString = NSBundle.mainBundle().pathForResource("test_data", ofType: "json")!
        let data:NSData = NSData(contentsOfFile: jsonFilePath as String, )!
        print(String(data: data, encoding: NSUTF8StringEncoding))
        var error: NSError?
        let json = JSON(data: data, options: NSJSONReadingOptions.MutableContainers, error: &error)
        if (error != nil) {
            print("error!!")
            print("error: \(error!.localizedDescription)")
        } else {
            print("no error. jsonData is nil: \(json != nil)")
        }
//        
//        //Copy file to app support directory so it's there next time
//        let fileManager = NSFileManager.defaultManager()
//        let urls = fileManager.URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
//        if let applicationSupportURL = urls.last {
//            let versionFileURL = applicationSupportURL.URLByAppendingPathComponent("characters_model.json")
//            do {
//                try fileManager.copyItemAtURL(url, toURL: versionFileURL)
//            } catch {
//                print("failed to copy characters model file")
//            }
//        }
        
        let dataSource = CharactersModelJsonAdapter()
        charactersModel = dataSource.loadCharactersModel(json)
    }
}

