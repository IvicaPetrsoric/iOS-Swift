//
//  AppDetailHeader.swift
//  AppStoreDemo
//
//  Created by Ivica Petrsoric on 06/12/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

class AppDetailHeader: BaseCell{
    
    var app: App?{
        didSet{
            if let imageName = app?.ImageName{
                imageView.image = UIImage(named: imageName)
            }
            
            nameLabel.text = app?.Name
            
            if let price = app?.Price{
                buyButton.setTitle("$\(price)", for: .normal)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.tintColor = .darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buy", for: .normal)
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(buyButton)
        addSubview(dividerLine)
        
        addConstrainsWithFormat(format: "H:|-14-[v0(100)]-8-[v1]", views: imageView, nameLabel)
        addConstrainsWithFormat(format: "V:|-14-[v0(100)]", views: imageView)
        
        addConstrainsWithFormat(format: "V:|-14-[v0(20)]", views: nameLabel)
        
        addConstrainsWithFormat(format: "H:|-40-[v0]-40-|", views: segmentedControl)
        addConstrainsWithFormat(format: "V:[v0(34)]-8-|", views: segmentedControl)
        
        addConstrainsWithFormat(format: "H:[v0(60)]-14-|", views: buyButton)
        addConstrainsWithFormat(format: "V:[v0(32)]-56-|", views: buyButton)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: dividerLine)
        addConstrainsWithFormat(format: "V:[v0(2)]|", views: dividerLine)
    }
    
}

extension UIView{
    
    func addConstrainsWithFormat(format: String, views: UIView...){
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
    }
}


class BaseCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
    }
}

