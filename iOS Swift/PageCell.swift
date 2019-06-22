//
//  PageCell.swift
//  audible
//
//  Created by Ivica Petrsoric on 17/10/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell{
    
    var page: Page?{
        didSet{
            
            guard let page = page else{
                return
            }
            
            var imageName = page.imageName
            if UIDevice.current.orientation.isLandscape{
                imageName += "_landscape"
            }
            
            imageView.image = UIImage(named: imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            // atributed string za sve u jedno, centriranje
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.strokeColor: color])
            
            attributedText.append(NSMutableAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.strokeColor: color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.characters.count
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
//            textView.text = page.title + "\n\n" + page.message
            textView.attributedText = attributedText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "page1")
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        return iv
    }()

    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample text for now"
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    func setupViews(){
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
        
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        
        textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        lineSeparatorView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
