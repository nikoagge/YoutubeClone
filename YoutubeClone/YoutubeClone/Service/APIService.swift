//
//  APIService.swift
//  YoutubeClone
//
//  Created by Nikolas on 13/05/2019.
//  Copyright © 2019 Nikolas Aggelidis. All rights reserved.
//


import UIKit


class APIService: NSObject {
    
    
    static let sharedInstance = APIService()
    
    let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    
    func fetchVideos(withCompletion completion: @escaping ([Video]) -> ()) {
        
//        fetchFeedForURL(forURLString: "\(baseURL)/home.json") { (videos) in
//
//            completion(videos)
//        }
        
        fetchFeedForURL(forURLString: "\(baseURL)/home.json", withCompletion: completion)
    }
    
    
    func fetchTrending(withCompletion completion: @escaping ([Video]) -> ()) {
        
//        fetchFeedForURL(forURLString: "\(baseURL)/trending.json") { (videos) in
//
//            completion(videos)
//        }
        
        //To avoid extra code for completion, can do this.
        fetchFeedForURL(forURLString: "\(baseURL)/trending.json", withCompletion: completion)
    }
    
    
    func fetchSubscriptions(withCompletion completion: @escaping ([Video]) -> ()) {
        
//        fetchFeedForURL(forURLString: "\(baseURL)/subscriptions.json") { (videos) in
//
//            completion(videos)
//        }
        
        //To avoid extra code for completion, can do this.
        fetchFeedForURL(forURLString: "\(baseURL)/subscriptions.json", withCompletion: completion)
    }
    
    
    func fetchFeedForURL(forURLString urlString: String, withCompletion completion: @escaping([Video]) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print(error ?? "")
                return
            }
            do {
                
                guard let safelyUnwrappedData = data, let jsonArrayOfDictionaries = try JSONSerialization.jsonObject(with: safelyUnwrappedData, options: .mutableContainers) as? [[String: AnyObject]] else { return }
                
                //Short example of higher function in Swift, specifically map.
//                let numbersArray = [1, 2, 3]
//                let doubleNumbersArray = numbersArray.map({return $0 * 2})
//                let stringsArray = numbersArray.map({return "\($0)"})
                DispatchQueue.main.async {
                    
                    completion(jsonArrayOfDictionaries.map({return Video(dictionary: $0)}))
                }
            } catch let jsonError {
                
                print(jsonError)
            }
        }.resume()
    }
}
    
//    func fetchFeedForURL(forURLString urlString: String, withCompletion completion: @escaping ([Video]) -> ()) {
//
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            if error != nil {
//
//                return
//            }
//
//            do {
//
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//                var videos = [Video]()
//
//                for dictionary in json as! [[String: AnyObject]] {
//
//                    let video = Video(dictionary: dictionary)
////                    video.title = dictionary["title"] as? String
////                    video.thumbnail_image_name = dictionary["thumbnail_image_name"] as? String
//                    //video.setValuesForKeys(dictionary)
//
//
//                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//                    let channel = Channel(channelDictionary)
////                    channel.name = channelDictionary["name"] as? String
////                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
//                    //channel.setValuesForKeys(channelDictionary)
//
//                    //video.channel = channel
//
//                    videos.append(video)
//                }
//
//                DispatchQueue.main.async {
//
//                    completion(videos)
//                }
//            } catch {
//
//                print(error)
//            }
//        }.resume()
//    }





//let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//var videos = [Video]()
//
//for dictionary in json as! [[String: AnyObject]] {
//
//    let video = Video()
//    video.title = dictionary["title"] as? String
//    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//
//    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//    let channel = Channel()
//    channel.name = channelDictionary["name"] as? String
//    channel.profileImageName = channelDictionary["profile_image_name"] as? String
//
//    video.channel = channel
//
//    videos.append(video)
//}
//
//DispatchQueue.main.async {
//
//    completion(videos)
//}
