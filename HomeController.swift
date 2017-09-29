import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {


    
    
    let cellId = "cellId"
    
    let baseBallCellId = "baseBallCellId"
    let NHLCellId = "NHLCellId"
    let NBACellId = "NBACellId"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.translucent = false
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, view.frame.width - 32, view.frame.height))
        titleLabel.text = "SportsTube"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
    }
    
    func setupCollectionView () {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .Horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(BaseBallCell.self, forCellWithReuseIdentifier: baseBallCellId)
        collectionView?.registerClass(NHLCell.self, forCellWithReuseIdentifier: NHLCellId)
        collectionView?.registerClass(NBACell.self, forCellWithReuseIdentifier: NBACellId)
        
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.pagingEnabled = true
    }

    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()

    func handleSearch() {
        scrollToMenuIndex(2)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(forItem: menuIndex, inSection: 0)
        collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
    }
    
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(31, green: 32, blue: 230)
        view.addSubview(redView)
        view.addConstraintsWithFormat("H:|[v0]|", views: redView)
        view.addConstraintsWithFormat("V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
  
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        if indexPath.item == 1 {
            return collectionView.dequeueReusableCellWithReuseIdentifier(baseBallCellId, forIndexPath: indexPath)
        } else if indexPath.item == 2 {
            return collectionView.dequeueReusableCellWithReuseIdentifier(NHLCellId, forIndexPath: indexPath)
        } else if indexPath.item == 3 {
            return collectionView.dequeueReusableCellWithReuseIdentifier(NBACellId, forIndexPath: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, view.frame.height - 50)
    }

}
