//
//  Webservice.swift
//  GoodWeather
//
//  Created by ivica petrsoric on 29/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import Foundation

struct Resource<T> {
    
    let url: URL
    let parse: (Data) -> T?

}

final class Webservice {
    
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data {
                    completion(resource.parse(data))
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
    
}
