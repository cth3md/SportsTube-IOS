import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame = frame
        
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        activityIndicatorView.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        
        backgroundColor = .blackColor()
        
        
        
        }
    
    private func setupPlayerView() {
        let urlString = "https://www.youtube.com/watch?v=9KzfdiWqbWE"
        if let url = NSURL(string: urlString){
            let player = AVPlayer(URL: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player.play()
            player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .New, context: nil)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clearColor()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.sharedApplication().keyWindow {
        let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.whiteColor()
            
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
        
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
                view.frame = keyWindow.frame
                }, completion:  { (completedAnimation) in
                    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
            })
        }
    }
}
