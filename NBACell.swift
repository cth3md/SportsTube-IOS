import UIKit

class NBACell: FeedCell {

// Retrieves all of the vidoes that are in the NBA feed    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchNBAFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
