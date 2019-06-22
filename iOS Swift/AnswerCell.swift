//
//  AnswerCell.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 22/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {
   
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample text"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    func setupViews(){
        addSubview(nameLabel)
        nameLabel.fillSuperview(padding: .init(top: 2, left: 16, bottom: 2, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
