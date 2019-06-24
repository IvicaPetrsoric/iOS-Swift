//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let gradientLayer = CAGradientLayer()

    lazy var  customNavBar: UIView = {
        let view = UIView()
        
        gradientLayer.colors = [
            #colorLiteral(red: 0.1848245859, green: 0.654030025, blue: 0.9077894688, alpha: 1).cgColor, #colorLiteral(red: 0.300840199, green: 0.3855857849, blue: 0.848775804, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        view.layer.addSublayer(gradientLayer)
        
        let labelsContainer = UIView()
        labelsContainer.stack(views:
            UILabel(text: "Statistics", font: .boldSystemFont(ofSize: 32), textColor: .white),
            UILabel(text: "Control your progress", font: .systemFont(ofSize: 14), textColor: .white)
        )
        
        view.addSubview(labelsContainer)
        labelsContainer.anchor(top: nil, leading: view.leadingAnchor,
                               bottom: view.bottomAnchor, trailing: view.trailingAnchor,
                               padding: .init(top: 0, left: 16, bottom: 12, right: 0))
        
        view.setupShadow(opacity: 0.4, radius: 8, offset: .init(width: 0, height: 5), color: #colorLiteral(red: 0.3031638265, green: 0.3841432929, blue: 0.8483528495, alpha: 1))
        
        return view
    }()
    
    let barChartView = BarChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9247675538, green: 0.9458522201, blue: 0.986253798, alpha: 1)
        
        view.addSubview(customNavBar)
        view.addSubview(barChartView)
        
        customNavBar.anchor(top: view.topAnchor, leading: view.leadingAnchor,
                            bottom: nil, trailing: view.trailingAnchor,
                            size: .init(width: 0, height: 150))
        
        barChartView.anchor(top: customNavBar.bottomAnchor, leading: view.leadingAnchor,
                            bottom: nil, trailing: view.trailingAnchor,
                            padding: .init(top: 32, left: 16, bottom: 0, right: 16),
                            size: .init(width: 0, height: 200))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer.frame = customNavBar.bounds
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}

