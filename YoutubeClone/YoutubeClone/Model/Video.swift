//
//  Video.swift
//  YoutubeClone
//
//  Created by Nikolas on 08/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import Foundation
import UIKit


class Video: SafeJSONObject {
    

    @objc var thumbnail_image_name: String?
    @objc var title: String?
    @objc var number_of_views: NSNumber?
    @objc var uploadDate: NSDate?
    @objc var duration: NSNumber?
    
    @objc var channel: Channel?
    
    
    override func setValue(_ value: Any?, forKey key: String) {
                
        if key == "channel" {
            
            //Custom channel setup
            self.channel = Channel(value as! [String: AnyObject])
        } else {
            
            super.setValue(value, forKey: key)
        }
    }
    
    
    init(dictionary: [String: AnyObject]) {
        
        super.init(dictionary)
        
        setValuesForKeys(dictionary)
    }
}
