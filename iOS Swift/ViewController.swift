//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//



import UIKit

class ViewController: UIViewController, Storyboarded {
    
    // Solution: #1
    weak var coordinator: (Buying & AccoutCreating)?
    
    // Solution: #2
    var buyAction: (() -> Void)?
    var createAccountAction: (() -> Void)?


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .red
    }

    @IBAction func buyTapped(_ sender: UIButton) {
        coordinator?.buySubscription()
        buyAction?()
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        coordinator?.createAccount()
        createAccountAction?()
    }
    
    
}

