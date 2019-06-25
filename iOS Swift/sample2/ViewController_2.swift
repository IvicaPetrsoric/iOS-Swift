//
//  ViewController.swift
//  GenericsAdvanced
//
//  Created by ivica petrsoric on 08/07/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class ViewController_2: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchHomeFeed { (homeFeed) in
            homeFeed.videos.forEach({print($0.name)})
        }
        
        fetchGenericData(urlString: "https://api.letsbuildthatapp.com/youtube/home_feed") { (homeFeed: HomeFeed) in
            homeFeed.videos.forEach({print($0.name)})
        }
        
//        fetchDetails { (courseDetails) in
//            courseDetails.forEach({print($0.name, $0.duration)})
//        }
        
        fetchGenericData(urlString: "https://api.letsbuildthatapp.com/youtube/course_detail?id=1") { (courseDetails: [CourseDetail]) in
            courseDetails.forEach({print($0.name, $0.duration)})
        }
        
        fetchGenericData(urlString: "https://api.letsbuildthatapp.com/jsondecodable/courses") { (courses: [Course]) in
            courses.forEach({print($0.link)})

        }
        
    }
    
    struct Course: Decodable {
        let id: Int
        let name: String
        let link: String
    }

    fileprivate func fetchHomeFeed(completion: @escaping (HomeFeed) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/youtube/home_feed"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch home feed:", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let homeFeed = try JSONDecoder().decode(HomeFeed.self, from: data)
                completion(homeFeed)
                
            } catch let jsonErr {
                print("Failed to serialize json:", jsonErr)
            }
            
        }.resume()
    }
    
    fileprivate func fetchDetails(completion: @escaping ([CourseDetail]) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/youtube/course_detail?id=1"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch home feed:", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let courseDetails = try JSONDecoder().decode([CourseDetail].self, from: data)
                completion(courseDetails)
                
            } catch let jsonErr {
                print("Failed to serialize json:", jsonErr)
            }
            
            }.resume()
    }
    
    fileprivate func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
//        let urlString = "https://api.letsbuildthatapp.com/youtube/course_detail?id=1"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch data:", err)
                return
            }
            
            guard let data = data else { return }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
                
            } catch let jsonErr {
                print("Failed to serialize json:", jsonErr)
            }
            
            }.resume()
    }

}

struct CourseDetail: Decodable {
    let name: String
    let duration: String
}

struct HomeFeed: Decodable {
    let videos: [Video]
}

struct Video: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
}

