import UIKit

class BaseBallCell: FeedCell {

// Retrieves all of the vidoes that are in the BaseBall feed    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchBaseBallFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        
        }
    }
}
