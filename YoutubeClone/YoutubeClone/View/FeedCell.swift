//
//  FeedCell.swift
//  YoutubeClone
//
//  Created by Nikolas on 14/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var videos: [Video]?
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    let cellIdentifier = "cellId"
    

    override func setupViews() {
        
        backgroundColor = .brown
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(withFormat: "H:|[v0]|", forViews: collectionView)
        addConstraintsWithFormat(withFormat: "V:|[v0]|", forViews: collectionView)
        
        collectionView.register(HomeVideoCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        fetchVideos()
    }
    
    
    func fetchVideos() {
        
        APIService.sharedInstance.fetchVideos { (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = videos?.count else { return 0 }
        
        return count
        
        //Also we can write this:
        //return videos?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HomeVideoCollectionViewCell
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    
    //With this change the size of collectionview's cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //The two 16 values which subtract inside parenthesis is the gap that I set left and right on thumbnailImageView from the super view. The 9 / 16 value is because I want to have 16:9 aspect ratio.
        let height = (frame.width - 16 - 16) * 9 / 16
        
        //Set width to view.frame.width to have cell expanded from left edge to right edge. In the height value except of the height that was calculated above, we add 16 pixels that we want for the top gap between the super view and the thumbnailImageView. We add 68 pixels more that are the gap between thumbnailImageView and two other views, userProfileImageView(8 for the gap and 44 pixels for the height) and separatorView(16 pixels more for the gap)
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let videoLauncher = VideoLauncherService()
        videoLauncher.showVideoPlayer()
    }
}
