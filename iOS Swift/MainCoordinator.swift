//
//  MainCoordinator.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 14/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

// if use storyboards
protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if #available(iOS 13.0, *) {
            return storyboard.instantiateViewController(identifier: id) as! Self
        } else {
            return storyboard.instantiateViewController(withIdentifier: id) as! Self
        }
    }
}

import Foundation
import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func buySubscription(to productType: Int) {
        let vc = BuyViewController.instantiate()
        vc.selectedProduct = productType
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func createAccount() {
        let vc = CreateAccountViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
