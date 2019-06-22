//
//  QuestionHeader.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 22/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class QuestionHeader: UITableViewHeaderFooterView {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample question"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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

