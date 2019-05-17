//
//  TrendingCell.swift
//  YoutubeClone
//
//  Created by Nikolas on 14/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class TrendingCell: FeedCell {
    
    
    override func fetchVideos() {
        
        APIService.sharedInstance.fetchTrending { (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
