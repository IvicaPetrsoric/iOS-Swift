//
//  BarChartCell.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 24/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class BarChartCell: GenericCell<BarData> {
    
    let indexLabel = UILabel(text: "0", font: .systemFont(ofSize: 10, weight: .regular), textColor: .lightGray, textAlignment: .center)
    
    lazy var barTrackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 4
        
        view.addSubview(self.barFillView)
        self.barFillView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        self.barFillHeightConstraint = self.barFillView.heightAnchor.constraint(equalTo: view.heightAnchor)
        self.barFillHeightConstraint.isActive = true
        return view
    }()
    
    var barFillHeightConstraint: NSLayoutConstraint!
    
    let barFillView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 4
        return view
    }()
    
    let dotView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    var dotViewContainer = UIView().withHeight(height: 24)
    var dotViewHeightConstraint: NSLayoutConstraint!
    var dotViewWidthConstraint: NSLayoutConstraint!
    
    override var item: BarData! {
        didSet {
            indexLabel.textColor = item.index % 6 == 0 ? .lightGray : .clear
            indexLabel.text = String(item.index)
            
            if item.index % 6 == 0 {
                dotViewHeightConstraint.constant = 6
                dotViewWidthConstraint.constant = 6
                dotView.layer.cornerRadius = 4
            } else {
                dotViewHeightConstraint.constant = 4
                dotViewWidthConstraint.constant = 4
                dotView.layer.cornerRadius = 2
            }
            
            barFillHeightConstraint.isActive = false
            barFillHeightConstraint = self.barFillView.heightAnchor.constraint(equalTo: barTrackView.heightAnchor, multiplier: item.percentage)
            barFillHeightConstraint.isActive = true
            barFillView.backgroundColor = item.color
        }
    }
    
    override func setupViews() {
        clipsToBounds = false
        
        stack(views:
            stack(.horizontal, views:
                UIView().withWidth(4),
                  barTrackView,
                  UIView().withWidth(4)),
              dotViewContainer,
              indexLabel, spacing: 0)
        
        dotViewContainer.addSubview(dotView)
        dotView.centerInSuperview()
        dotViewHeightConstraint = dotView.heightAnchor.constraint(equalToConstant: 0)
        dotViewWidthConstraint = dotView.widthAnchor.constraint(equalToConstant: 0)
        dotViewHeightConstraint.isActive = true
        dotViewWidthConstraint.isActive = true
        dotView.centerXAnchor.constraint(equalTo: indexLabel.centerXAnchor).isActive = true
    }
    
}

