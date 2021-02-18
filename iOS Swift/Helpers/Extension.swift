//
//  Extension.swift
//  youtube
//
//  Created by Ivica OS X on 28/06/17.
//  Copyright © 2017 Ivica OS X. All rights reserved.
//

import UIKit

extension UIColor{
    
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}


extension UIView{
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
    }
}

//image cash
let imageCache = NSCache<NSString, UIImage>()


class CustomImageView: UIImageView{
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(_ urlString: String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString){
            self.image = imageFromCache
            return // break
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data,response,error) in
            
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            
            DispatchQueue.main.async(execute: {                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                
            })
            
        }).resume()
        
    }
}














