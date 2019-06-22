//
//  MainNavigationController.swift
//  audible
//
//  Created by Ivica Petrsoric on 18/10/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if isLoggedIn(){
            let homeController = HomeController()
            viewControllers = [homeController]
        } else{
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    func isLoggedIn() -> Bool{
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func showLoginController(){
        let loginController = LoginController()
        present(loginController, animated: true, completion: {
            //
        })
    }
}


