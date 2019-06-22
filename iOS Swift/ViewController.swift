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
        
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap(){
        (0...10).forEach{ (_) in
            genetateAnimatedViews()
        }
    }
    
    fileprivate func genetateAnimatedViews(){
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "player_0_X1") : #imageLiteral(resourceName: "player_40_X1")
        
        let imageView = UIImageView(image: image)
        let dimension = 20 + drand48() * 10  // izmedu 10 i 30, drand = 0 - 1
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            imageView.removeFromSuperview()
        })
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath(imgWidht: dimension).cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        imageView.layer.add(animation, forKey: nil)
        
        CATransaction.commit()
        
        view.addSubview(imageView)
    }
    
    func customPath(imgWidht: Double) -> UIBezierPath{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -CGFloat(imgWidht/2), y: 200))
        
        let endPoint = CGPoint(x: UIScreen.main.bounds.width + CGFloat(imgWidht/2), y: 200)
        
        let randomYShift = 200 + drand48() * 300
        
        let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
        let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
        
        //path.addLine(to: endPoint)
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        
        return path
        
    }
    
}

