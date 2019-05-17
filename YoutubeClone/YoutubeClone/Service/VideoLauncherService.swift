//
//  VideoLauncherService.swift
//  YoutubeClone
//
//  Created by Nikolas on 17/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import Foundation
import UIKit


class VideoLauncherService: NSObject {
    
    
    func showVideoPlayer() {
        
        
        //Because I 'm in an NSObject, create a view like this:
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        let view = UIView(frame: keyWindow.frame)
        view.backgroundColor = .white
        
        //To make the new view animate as we want, we have to set a starting frame and an ending frame, like this:
        //Starting point is bottom right corner of the keyWindow.
        view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
        
        //16 x 9 is the aspect ratio of all HD videos.
        let height = keyWindow.frame.width * 9 / 16
        let videoPlayerViewFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
        let videoPlayerView = VideoPlayerView(frame: videoPlayerViewFrame)
        
        view.addSubview(videoPlayerView)
        
        keyWindow.addSubview(view)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            //Ending point of our animation
            view.frame = keyWindow.frame
        }) { (completionAnimation) in
            
            UIApplication.shared.setStatusBarHidden(true, with: .fade)
        }
    }
}
