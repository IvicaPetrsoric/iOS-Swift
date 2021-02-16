//
//  CustomTabBarController.swift
//  fbMessenger
//
//  Created by Ivica Petrsoric on 01/12/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessegesController = UINavigationController(rootViewController: friendsController)
        recentMessegesController.tabBarItem.title = "Recent"
        recentMessegesController.tabBarItem.image = UIImage(named: "recent")
        
        viewControllers = [
            recentMessegesController,
            createDummyNavControllerWithTitle(title: "Calls", imageName: "calls"),
            createDummyNavControllerWithTitle(title: "Groups", imageName: "groups"),
            createDummyNavControllerWithTitle(title: "People", imageName: "people"),
            createDummyNavControllerWithTitle(title: "Settings", imageName: "settings"),
        ]
    }
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController{
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
}
