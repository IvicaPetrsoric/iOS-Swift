//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    
    // propertyAnimator
    let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    
    let visualEffectView = UIVisualEffectView(effect: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCenteredImageView()
        setupBlurEffect()
        setupSlider()
        
        animator.addAnimations {
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
    }
    
    fileprivate func setupBlurEffect() {
        view.addSubview(visualEffectView)
        visualEffectView.fillSuperview()
    }
    
    fileprivate func setupSlider() {
        let slider = UISlider()
        view.addSubview(slider)
        slider.anchor(top: imageView.bottomAnchor, leading: imageView.leadingAnchor, bottom: nil, trailing: imageView.trailingAnchor)
        slider.addTarget(self, action: #selector(handleSliderValueChanged), for: .valueChanged)
    }
    
    @objc fileprivate func handleSliderValueChanged(slider: UISlider) {
        print("slider value: \(slider.value)")
        animator.fractionComplete = CGFloat(slider.value)
    }
    
    @objc func handleTap() {
        UIView.animate(withDuration: 1) {
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    fileprivate func setupCenteredImageView() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.centerInSuperview(size: .init(width: 200, height: 200))
    }
    
}



