import Foundation
import SwiftyJSON

public class GetDataVersionTask {
    
    var data: NSData?
    
    func loadData(currentDataVersion: Int, listener: GetDataVersionTaskListener) {
        
        let urlString = "http://still-hollows-20653.herokuapp.com/dataVersion?endpoint=iOS"
        let url:NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _: NSURLResponse = response  where error == nil else {
                print("error")
                listener.onError()
                return
            }
            
            print("successful dataVersion response")
            self.data = data
            self.processResponse(currentDataVersion, listener: listener)
        }
        
        task.resume()
    }
    
    private func processResponse(currentDataVersion: Int, listener: GetDataVersionTaskListener) {
        var error: NSError?
        let jsonData = JSON(data: data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        print("\(jsonData)")
        
        if (error != nil) {
            listener.onError()
        }
        
        var success  = false
        
        if let dataVersion = jsonData["dataVersion"].int {
            if let minimumSupportedVersion = jsonData["minSupportediOSVersion"].int {
                success = true
                processDataVersion(dataVersion, minimumSupportedAppVersion: minimumSupportedVersion, currentDataVersion: currentDataVersion, listener: listener)
            }
        }
        
        if (!success) {
            listener.onError()
        }
    }
    
    private func processDataVersion(availableDataVersion: Int, minimumSupportedAppVersion: Int, currentDataVersion: Int, listener: GetDataVersionTaskListener) {
        
        let appVersion = Int(NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String)!
        print("have app version: \(appVersion)")
        
        if (appVersion < minimumSupportedAppVersion) {
            listener.onVersionOutOfDate()
        } else if (availableDataVersion > currentDataVersion) {
            listener.onNewDataAvailable()
        } else {
            listener.onUpToDate()
        }
    }

}