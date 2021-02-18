//
//  ApiService.swift
//  youtube
//
//  Created by Ivica OS X on 30/06/17.
//  Copyright © 2017 Ivica OS X. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(_ completion: @escaping ([Video]) -> ()){
        fetchFeedForUrlString("\(baseUrl)/home_num_likes.json", completion: completion)
    }
    
    func fetchTrendingFeed(_ completion: @escaping ([Video]) -> ()){
        fetchFeedForUrlString("\(baseUrl)/trending.json", completion: completion)
    }

    
    func fetchSubscriptionFeed(_ completion: @escaping ([Video]) -> ()){
        fetchFeedForUrlString("\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(_ urlString: String, completion: @escaping ([Video]) -> ()){
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            
            do {
                if let unwrapedData = data, let jsonDictionaries =  try JSONSerialization.jsonObject(with: unwrapedData, options: .mutableContainers) as? [[String: AnyObject]]{
  
                    DispatchQueue.main.async(execute: {
                        completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                    })
                }
                
            }catch let jsonError{
                print(jsonError)
            }
            
            }) .resume()
    }

}
