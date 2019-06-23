//
//  Video.swift
//  youtube
//
//  Created by Ivica OS X on 29/06/17.
//  Copyright © 2017 Ivica OS X. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject{
    
    override func setValue(_ value: Any?, forKey key: String) {       
         let uppercasedFirstCharacher = String(key.characters.first!).uppercased()
         
//         let range = key.startIndex...key.characters.index(key.startIndex, offsetBy: 0) // prvi karakter
//         let selectorsString = key.replacingCharacters(in: range, with: uppercasedFirstCharacher)
        // riješava ako ne postoji objekt 
        let range = NSMakeRange(0,1)
        let selectorsString = NSString(string: key).replacingCharacters(in: range, with: uppercasedFirstCharacher)
        
         
         // ako se dodaje novi parameter na server a ne postoji u skripti
         let selector = NSSelectorFromString("set\(selectorsString):")
         let responds = self.responds(to: selector)
         
         if !responds{
            return
         }
        
        super.setValue(value, forKey: key)
    }
    
}

//class Video: NSObject{
class Video: SafeJsonObject{
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: Data?
    var duration: NSNumber?
    
    var channel: Channel?
    
    
//    var numb_likes: NSNumber?
    
    override func setValue(_ value: Any?, forKey key: String) {

        
        if key == "channel"{
            self.channel = Channel()
            channel?.setValuesForKeys(value as! [String: AnyObject])
        }
        else{
            super.setValue(value, forKey: key)      // poziva SafeJsonObject
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
}


//class Channel: NSObject{
class Channel: SafeJsonObject{
    var name: String?
    var profile_image_name: String?
    
}
