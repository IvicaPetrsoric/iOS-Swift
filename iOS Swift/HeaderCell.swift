//
//  HeaderCell.swift
//  StrechyHeaderCollectionView
//
//  Created by ivica petrsoric on 20/01/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "stretchy_header"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var animator: UIViewPropertyAnimator!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
//        imageView.image = nil
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupVisualEffectBlur()
        
        setupGradientLayer()
    }
    
    let gradientLayer = CAGradientLayer()

    private func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1]
        
//        layer.addSublayer(gradientLayer)
        
        let gradientContainerView = UIView()
        gradientContainerView.backgroundColor = .red
        addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)
        
        
        let heavyLabel = UILabel()
        heavyLabel.text = "Surf the web for courses"
        heavyLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        heavyLabel.textColor = .white
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Go onto the website and buy more stuff otherwise a sad puppy will be in front of you!"
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [
            heavyLabel, descriptionLabel
            ])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    fileprivate func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: { [weak self] in
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffect = UIVisualEffectView(effect: blurEffect)
            
            self?.addSubview(visualEffect)
            visualEffect.fillSuperview()
        })
        
        animator.fractionComplete = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= bounds.height

    }
    
    
}
