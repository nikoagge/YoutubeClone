//
//  HomeController.swift
//  YoutubeClone
//
//  Created by Nikolas on 02/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
//    var videos: [Video] = {
//
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeIsTheBestChannel"
//        kanyeChannel.profileImageName = "kanye_profile"
//
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
//        blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numberOfViews = 128584149141
//
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfViews = 1232345841920
//
//        return [blankSpaceVideo, badBloodVideo]
//    }()
    
    let cellIdentifier = "cellId"
    let trendingCellIdentifier = "trendingCellId"
    let subscriptionsCellIdentifier = "subscriptionsCellId"
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    lazy var menuBar: MenuBar = {
       
        let mb = MenuBar()
        mb.homeController = self
        
        return mb
    }()
    
    static let sharedInstance = HomeController()
    
    lazy var settingsLauncherController: SettinsLauncherController = {
        
        let launcher = SettinsLauncherController()
        launcher.homeController = self
        
        return launcher
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .rgb(ofRed: 230, ofGreen: 32, ofBlue: 31)
        //In order to make little black line between navBar and menuBar I write following lines of code.
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    
    func setupCollectionView() {
        
        //Set scrollDirection to horizontal.
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.scrollDirection = .horizontal
        //In order to not show any gap between paging, write this.
        flowLayout.minimumLineSpacing = 0
        
        collectionView.backgroundColor = .white
        //collectionView.register(HomeVideoCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellIdentifier)
        collectionView.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsCellIdentifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.isPagingEnabled = true
    }
    
    
    private func setupMenuBar() {
        
        //In order to hide the top menu bar when scrolling, write following line of code.
        navigationController?.hidesBarsOnSwipe = true
        
        //Also, so to not have a gap between menuBar and view's safeAreaLayoutGuide, I do this hack.
        let redView = UIView()
        redView.backgroundColor = .rgb(ofRed: 230, ofGreen: 32, ofBlue: 31)
        
        view.addSubview(redView)
        
        view.addConstraintsWithFormat(withFormat: "H:|[v0]|", forViews: redView)
        view.addConstraintsWithFormat(withFormat: "V:[v0(50)]", forViews: redView)
        
        view.addSubview(menuBar)
        
        view.addConstraintsWithFormat(withFormat: "H:|[v0]|", forViews: menuBar)
        view.addConstraintsWithFormat(withFormat: "V:[v0(50)]", forViews: menuBar)
        
        //In order to have menuBar and view's topAnchor shown together when scrolling, write following.
        menuBar.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    
    func setupNavBarButtons() {
        
        //withRenderingMode(.alwaysOriginal) option shows Image with white color, .alwaysTemplate option shows the image with dark color
        let searchImage = #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal)
        let searchButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let navMoreImage = #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal)
        let navMoreButtonItem = UIBarButtonItem(image: navMoreImage, style: .plain, target: self, action: #selector(handleNavMore))
        
        navigationItem.rightBarButtonItems = [navMoreButtonItem, searchButtonItem]
    }
    
    
    @objc func handleSearch() {
        
        scrollToMenuIndex(atMenuIndex: 2)
    }
    
    
    @objc func handleNavMore() {
        
        settingsLauncherController.showSettings()
    }
    
    
    private func setTitleForIndex(forIndex index: Int) {
        
        guard let titleLabel = navigationItem.titleView as? UILabel else { return }
        titleLabel.text = "  \(titles[Int(index)])"
    }
    
    
    func scrollToMenuIndex(atMenuIndex menuIndex: Int) {
        
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        
        setTitleForIndex(forIndex: menuIndex)
    }
    
    
    func showViewControllerForSetting(forSetting setting: Setting) {

        let sampleSettingsVC = UIViewController()
        //In order to set viewController's backgroundColor to white, write the following line of code.
        sampleSettingsVC.view.backgroundColor = .white
        sampleSettingsVC.navigationItem.title = setting.name.rawValue
        
        //In order to set navigationController's navigationBar's left item title white, write the following line of code.
        navigationController?.navigationBar.tintColor = .white
        //In order to set viewController's title's color to white, write the following line of code.
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(sampleSettingsVC, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        switch indexPath.item {
            
        case 1:
            identifier = trendingCellIdentifier
            
        case 2:
            identifier = subscriptionsCellIdentifier
            
        default:
            identifier = cellIdentifier
        }
        //let colors: [UIColor] = [.blue, .green, .gray, .purple]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //In order not to cells are so high and there is a little gap between first cell and menuBar I subtract 50 pixels(because 50 pixels high is menuBar).
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.x)
       
        //In order not to the menuBar white line gets out of the menuBar, divide by 4.
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //In this function we get the index of the view that we are is this.
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
        setTitleForIndex(forIndex: Int(index))
    }
}

