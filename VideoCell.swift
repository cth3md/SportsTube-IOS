import UIKit

class BaseCell: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell{
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            setupProfileImage()
            
          
            if let channelName = video?.channel?.name, numberOfViews = video?.number_of_views {
                
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = .DecimalStyle
            
            let subtitleText = "\(channelName) - \(numberFormatter.stringFromNumber(numberOfViews)!) - 2 years ago "
            subtitleTextView.text = subtitleText
            }
            
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profile_image_name {
            userProfileImageView.loadImageUsingUrlString(profileImageUrl)
        }
    }
    func setupThumbnailImage() {
        if let thumbnailImageURL = video?.thumbnail_image_name {
            thumbnailImageView.loadImageUsingUrlString(thumbnailImageURL)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "maxresdefault")
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGrayColor()
        return textView
    }()
    

    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        addConstraintsWithFormat("H:|[v0]|", views: separatorView)
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 20))
        
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
        
    }
}
