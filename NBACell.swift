import UIKit

class NBACell: FeedCell {

    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchNBAFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
