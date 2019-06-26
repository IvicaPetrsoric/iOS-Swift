//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sharedResource = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        fetchSomething { (d1, r1, e1) in
//            self.fetchSomething(completion: { (d2, r2, e2) in
//                self.fetchSomething(completion: { (d3, r3, e3) in
//                    print("Completed fecth")
//                })
//            })
//        }
        
        // async-await
//        do {
//            try fetchSomething()
//        } catch err {
//            print("Failed to fetch something1")
//            return
//        }
//
//        do {
//            try fetchSomething()
//        } catch err {
//            print("Failed to fetch something2")
//        }
//
//        do {
//            try fetchSomething()
//        } catch err {
//            print("Failed to fetch something3")
//        }
        
        
//        do {
//            let data = try fetchSomethingAsyncAwait()
//            let s = String(decoding: data!, as: UTF8.self)
//            print("data: ", s)
//        } catch {
//            print("Failed to fetch stuff: ", error)
//            return
//        }
        
//        let imageView = UIImageView()
//        view.addSubview(imageView)
//        imageView.fillSuperview()
//
//        fetchImage { (image, err) in
//            DispatchQueue.main.async {
//                imageView.image = image
//            }
//        }
        
        
//        testDispatchGroup()
        
        testSemaphore()
    }
    
    func testDispatchGroup() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchImage { (_, _) in
            print("Finished fetching image 1")
            self.sharedResource.append("1")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchImage { (_, _) in
            print("Finished fetching image 2")
            self.sharedResource.append("2")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        fetchImage { (_, _) in
            print("Finished fetching image 3")
            self.sharedResource.append("3")
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Finished fetching images")
        }
    }
    
    func testSemaphore() {
        let semaphore = DispatchSemaphore(value: 0)
        let dispatchQueue = DispatchQueue.global(qos: .background)
        
        dispatchQueue.async {

            self.fetchImage { (_, _) in
                print("Finished fetching image 1")
                self.sharedResource.append("1")
                semaphore.signal()
            }
            semaphore.wait()
            
            self.fetchImage { (_, _) in
                print("Finished fetching image 2")
                self.sharedResource.append("2")
                semaphore.signal()
            }
            semaphore.wait()
            
            self.fetchImage { (_, _) in
                print("Finished fetching image 3")
                self.sharedResource.append("3")
                semaphore.signal()
            }
            semaphore.wait()
        }
        
        print("Start fetching images")
    }

    
    
    enum NetworkError: Error {
        case url
        case statusCode
        case standardError
    }
    
    // async await
    func fetchSomethingAsyncAwait() throws -> Data? {
        guard let dummyUrl = URL(string: "https://www.google.com") else { throw NetworkError.url }
        
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        // semaphore
        let semaphore = DispatchSemaphore(value: 0)

        URLSession.shared.dataTask(with: dummyUrl) { (d, r, e) in
            data = d
            response = r
            error = e
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode > 300 {
            throw NetworkError.statusCode
        }
        
        if let _  = error {
            throw NetworkError.standardError
        }
        
        return data
    }

    // callBack hell
    func fetchSomething(completion: @escaping(Data?, URLResponse?, Error?) -> ()) {
        guard let dummyUrl = URL(string: "https://www.google.com") else { return }
        URLSession.shared.dataTask(with: dummyUrl) { (data, res, err) in
            completion(data, res, err)
        }.resume()
    }
    
    
    
    
    
    
    func fetchImage(completion: @escaping (UIImage?, Error?) -> ()) {
        guard let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/5a90871e-408a-46da-a43c-210348a67082") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            completion(UIImage(data: data ?? Data()), nil)
        }.resume()
    }

}

