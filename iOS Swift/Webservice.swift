//
//  Webservice.swift
//  GoodNews
//
//  Created by ivica petrsoric on 25/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class Webservice {
    
    func getArticles(url: URL, completion: @escaping([Article]?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let articleList = try JSONDecoder().decode(ArticleList.self, from: data)
                completion(articleList.articles)
                
            } catch {
                print(error)
                completion(nil)
            }
            
        }.resume()
    }
    
}

