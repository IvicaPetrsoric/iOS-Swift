//
//  HeaderCell.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 22/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewHeaderFooterView{
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample text"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .blue
        return label
    }()
    
    func setupViews(){
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,
                         padding: .init(top: 0, left: 16, bottom: 0, right: 0))
    }
    
}
