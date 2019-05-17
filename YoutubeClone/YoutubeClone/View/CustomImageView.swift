//
//  ImageViewExtension.swift
//  YoutubeClone
//
//  Created by Nikolas on 10/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import Foundation
import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()


class CustomImageView: UIImageView {
    
    
    var imageURLString: String?
    
    
    func loadImageUsingURLString(forURLString urlString: String) {
        
        image = nil
        
        imageURLString = urlString
        
        //Getting image, if it exists, from cache.
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            
            self.image = imageFromCache
            
            return
        }
        
        //Otherwise get image from JSON file.
        let url = URL(string: urlString)
        
        guard let safelyUnwrappedURL = url else { return }
        URLSession.shared.dataTask(with: safelyUnwrappedURL) { (data, response, error) in
            
            if error != nil {
                
                print(error!)
                
                return
            }
            
            guard let safelyUnwrappedData = data else { return }
            
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: safelyUnwrappedData)
                guard let safelyUnwrappedImageToCache = imageToCache else { return }
               
                if self.imageURLString == urlString {
                    
                   self.image = imageToCache
                }
                
                //Matches image with urlString and storing it to cache.
                imageCache.setObject(safelyUnwrappedImageToCache, forKey: urlString as AnyObject)
            }
            }.resume()
    }
}
