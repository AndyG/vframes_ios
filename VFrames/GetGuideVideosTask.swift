import Foundation
import SwiftyJSON

public class GetGuideVideosTask {
    
    var data: NSData?
    
    func loadData(listener: GetVideosTaskListenerProtocol, character: String) {
        let urlString = "http://still-hollows-20653.herokuapp.com/guideVideos?character=\(character)"
        
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
            
            print("successful getVideos response")
            self.data = data
            self.processResponse(listener)
        }
        
        task.resume()
    }
    
    private func processResponse(listener: GetVideosTaskListenerProtocol) {
        var error: NSError?
        let jsonData = JSON(data: data!, options: NSJSONReadingOptions.MutableContainers, error: &error)
        
        if (error != nil) {
            listener.onError()
        }
        
        let guideVideos = GuideVideosJsonAdapter.loadVideos(jsonData.arrayValue)
        let getYoutubeVideosTask = GetYoutubeVideosTask()
        getYoutubeVideosTask.getYoutubeVideos(guideVideos, listener: listener)
    }
    
}