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
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        
        setupSimpleTextAnim()
    }
    
    fileprivate func setupSimpleTextAnim() {
        let darkTextLabel = UILabel()
        darkTextLabel.text = "Shimmer"
        darkTextLabel.textAlignment = .center
        darkTextLabel.textColor = UIColor(white: 1, alpha: 0.2)
        darkTextLabel.font = UIFont.systemFont(ofSize: 80)
        darkTextLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        
        view.addSubview(darkTextLabel)
        
        let shinyTextLabel = UILabel()
        shinyTextLabel.text = "Shimmer"
        shinyTextLabel.textAlignment = .center
        shinyTextLabel.textColor = .white
        shinyTextLabel.font = UIFont.systemFont(ofSize: 80)
        shinyTextLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        
        view.addSubview(shinyTextLabel)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = shinyTextLabel.frame
        
        let angle = -60 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        
        shinyTextLabel.layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3
        animation.repeatCount = Float.infinity
        animation.autoreverses = false
        animation.fromValue = -1.2 * view.frame.width
        animation.toValue = 1.2 * view.frame.width
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        gradientLayer.add(animation, forKey: "rndkey")
        
    }

}



