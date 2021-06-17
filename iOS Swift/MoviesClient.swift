//
//  MoviesClient.swift
//  TopMovie
//
//  Created by ivica petrsoric on 24/06/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class MoviesClient: NSObject {

    func fetchMovies(completion: @escaping ([NSDictionary]?) -> ()) {
        let urlString = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            if let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                if let movies = json.value(forKeyPath: "feed.entry") as? [NSDictionary] {
                    completion(movies)
                    return
                }
            }
        }
        
        task.resume()
    }
    
}
