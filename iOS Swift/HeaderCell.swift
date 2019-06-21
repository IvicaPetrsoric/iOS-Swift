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
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupVisualEffectBlur()
    }
    
    fileprivate func setupVisualEffectBlur() {
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: { [weak self] in
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffect = UIVisualEffectView(effect: blurEffect)
            
            self?.addSubview(visualEffect)
            visualEffect.fillSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
