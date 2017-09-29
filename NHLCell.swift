import UIKit

class NHLCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchNHLFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
