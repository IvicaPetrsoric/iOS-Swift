//
//  Webservice.swift
//  HotCoffe
//
//  Created by ivica petrsoric on 26/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T: Codable> {

    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data?
    
    init(url: URL) {
        self.url = url
    }
    
}

class Webservice {
    
    func load<T>(resource: Resource<T>, completion: @escaping(Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, reeesponse, error) in
            if let error = error {
                print("Failed with error:", error)
                completion(.failure(.domainError))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
}

