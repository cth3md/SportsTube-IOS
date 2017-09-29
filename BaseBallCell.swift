import UIKit

class BaseBallCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchBaseBallFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        
        }
    }
}
