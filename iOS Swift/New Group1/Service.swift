//  Service.swift
//  AppStoreDemo
//
//  Created by Ivica Petrsoric on 05/12/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

class Service: NSObject{
    
    // https://api.letsbuildthatapp.com/appstore/featured
    // https://api.letsbuildthatapp.com/appstore/appdetail?id=1
    
    func fetchFeaturedApps(completion: @escaping (FeaturedApps) -> ()){
        let urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil{
                print("Error fetch", error as Any)
                return
            }
            
            do{
                let decodedApps = try JSONDecoder().decode(FeaturedApps.self, from: data!)
                
                    // stari način
//                guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] else{
//                    return
//                }
//
//                var appCategoriest = [AppCategory]()
//
//                for dict in json["categories"] as! [[String: AnyObject]]{
//                    let appCategory = AppCategory(dictionary: dict)
//                    appCategoriest.append(appCategory)
//                }
                
                DispatchQueue.main.async {
                    completion(decodedApps)
                }

            } catch let err{
                print(err)
            }
            
        }.resume()
    }
    
    func fetchAppDetails(id: String, completion: @escaping(App) -> ()){
        let urlString = "https://api.letsbuildthatapp.com/appstore/appdetail?id=\(id)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil{
                print(error as Any)
                return
            }
            
            do{
                
                guard let data = data else { return }
                
                let appDetails = try JSONDecoder().decode(App.self, from: data)
                
                DispatchQueue.main.async {
                    completion(appDetails)
                }
                
            }catch let err{
                print(err)
            }
        }.resume()
    }
}













