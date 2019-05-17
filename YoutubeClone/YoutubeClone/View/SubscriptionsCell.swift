//
//  SubscriptionsCell.swift
//  YoutubeClone
//
//  Created by Nikolas on 14/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class SubscriptionsCell: FeedCell {
    
    
    override func fetchVideos() {
        
        APIService.sharedInstance.fetchSubscriptions { (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
