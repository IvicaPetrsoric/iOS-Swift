//
//  Models.swift
//  AppStoreDemo
//
//  Created by Ivica Petrsoric on 05/12/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

//class AppCategory: NSObject{
//
//    var name: String?
//    var apps: [App]?
//    var type: String?
//
//    static func sampleAppCategories () -> [AppCategory] {
//        // category 1
//        let bestNewAppsCategory = AppCategory()
//        bestNewAppsCategory.name = "Best New Apps"
//
//        var apps = [App]()
//
//        let frozenApp = App()
//        frozenApp.name = "Disney build it: Frozen"
//        frozenApp.imageName = "frozen"
//        frozenApp.category = "Entertaiment"
//        frozenApp.price = NSNumber(floatLiteral: 3.99)
//        apps.append(frozenApp)
//
//        bestNewAppsCategory.apps = apps
//
//
//        // category 2
//        let bestNewGamesCategory = AppCategory()
//        bestNewGamesCategory.name = "Best New Games"
//
//        var bestNewGamesApps = [App]()
//
//        let telepainApp = App()
//        telepainApp.name = "Telepaint"
//        telepainApp.category = "Games"
//        telepainApp.imageName = "telepaint"
//        telepainApp.price = NSNumber(floatLiteral: 2.99)
//
//        bestNewGamesApps.append(telepainApp)
//
//        bestNewGamesCategory.apps = bestNewGamesApps
//
//
//        return [bestNewAppsCategory, bestNewGamesCategory]
//    }
//}

struct FeaturedApps: Decodable {
    let bannerCategory: AppCategory?
    let categories: [AppCategory]?
}

struct AppCategory: Decodable{

    let name: String?
    let apps: [App]?
    let type: String?
}

struct App: Decodable{

    let Id: Double?
    let Name: String?
    let Category: String?
    let ImageName: String?
    let Price: Double?
    
    var Screenshots: [String]?
    var description: String?
    var appInformation: [AppInformation]?
    
//    var appInformation: AnyObject?
}

struct AppInformation: Decodable {
    let Name: String?
    let Value: String?
}


// old solution
/*
class AppCategory: NSObject{
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    init(dictionary: [String: AnyObject]){
        super.init()
        
        self.name = dictionary["name"] as? String
        self.type = dictionary["type"] as? String

        apps = [App]()
        for dict in dictionary{
            if dict.key == "apps"{
                
                for j in dict.value as! [AnyObject]{
                    let app = App(dictionary: j as! [String : AnyObject])
                    apps?.append(app)
                }
            }
        }
    }
}
 */

//class App: NSObject{
//
//    var id: NSNumber?
//    var name: String?
//    var category: String?
//    var imageName: String?
//    var price: NSNumber?
//}

// old solution
/*
class App: NSObject{
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
    
    init(dictionary: [String: AnyObject]){
        super.init()
        
        for j in dictionary{
            
            if j.key == "Id"{
                self.id = j.value as? NSNumber
            }
            
            if j.key == "Name"{
                self.name = j.value as? String
            }
            
            if j.key == "Category"{
                self.category = j.value as? String
            }
            
            if j.key == "ImageName"{
                self.imageName = j.value as? String
            }
            
            if j.key == "Price"{
                self.price = j.value as? NSNumber
            }
        }
    }
}
*/



//    func setupValues(dictionary: [String: AnyObject]){
//    self.id = j["Id"] as? NSNumber
//    self.name = dictionary["Name"] as? String
//    self.category = dictionary["Category"] as? String
//    self.imageName = dictionary["ImageName"] as? String
//    self.price = dictionary["Price"] as? NSNumber
//    }
