import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    // Get NFL stream json
    func fetchVideos(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("https://s3-us-west-2.amazonaws.com/youtubeassets/NFL.json") { (videos) in
            completion(videos)
        }
    }

    // Get MLB steam json
    func fetchBaseBallFeed(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("https://s3-us-west-2.amazonaws.com/youtubeassets/MLB.json") { (videos) in
            completion(videos)
        }
    }
    
    // Get NHL stream json
    func fetchNHLFeed(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("https://s3-us-west-2.amazonaws.com/youtubeassets/NHL.json") { (videos) in
            completion(videos)
        }
    }
    
    // Get NBA stream json
    func fetchNBAFeed(completion: ([Video]) -> ()) {
        fetchFeedForUrlString("https://s3-us-west-2.amazonaws.com/youtubeassets/NBA.json") { (videos) in
            completion(videos)
        }
    }
    
    // Load all of the json data from the url, and store. 
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
