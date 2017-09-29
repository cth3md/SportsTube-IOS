import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") { (videos) in
            completion(videos)
        }
    }

    
    func fetchBaseBallFeed(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json") { (videos) in
            completion(videos)
        }
    }
    
    func fetchNHLFeed(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json") { (videos) in
            completion(videos)
        }
    }
    
    func fetchNBAFeed(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json") { (videos) in
            completion(videos)
        }
    }

    func fetchFeedForUrlString(urlString: String, completion: ([Video]) -> () ) {
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
    
        if error != nil {
        print(error)
        return
        }
    
        do {
        
            if let unwrappedData = data, jsonDictionaries = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: .MutableContainers) as? [[String: AnyObject]] {
    
                let videos = jsonDictionaries.map({return Video(dictionary: $0)})
                
        dispatch_async(dispatch_get_main_queue(), {
            completion(videos)
        })
                
    }
    
        } catch let jsonError {
        print(jsonError)
        }
    
        }.resume()
    }
}
