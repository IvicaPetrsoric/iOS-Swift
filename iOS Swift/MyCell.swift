//
//  MyCell.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 22/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell{
    
    var myTableViewController: MyTableViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        return label
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        return button
    }()
    
    func setupViews(){
        addSubview(nameLabel)
        addSubview(actionButton)
        
        nameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil,
                         padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        actionButton.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor,
                            padding: .init(top: 0, left: 0, bottom: 0, right: 16))
    }
    
    @objc func handleAction(){
        print("touch")
        myTableViewController?.deleteCell(cell: self)
    }
    
}
