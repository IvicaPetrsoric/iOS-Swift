//
//  BuyCoordinator.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 14/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import UIKit

class BuyCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BuyViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    // approach #1
//    func didFinishBuying() {
//        parentCoordinator?.childDidFinish(self)
//    }
    
}
