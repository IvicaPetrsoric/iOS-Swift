//
//  BuyViewController.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 14/02/2021.
//  Copyright © 2021 ivica petrsoric. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, Storyboarded {

    weak var coordinator: BuyCoordinator?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // approach #1
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        coordinator?.didFinishBuying()
//    }

}
