//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let storyboard = UIStoryboard(name: "TextFieldViewController", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! TextFieldViewController
        controller.modalPresentationStyle = .fullScreen
        
        navigationController?.present(controller, animated: true)
//        navigationController?.pushViewController(controller, animated: true)

    }


}

