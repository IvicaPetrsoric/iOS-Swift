//
//  BarChartView.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 24/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class BarChartView: UIView {
    
    let titleLabel = UILabel(text: "Focus Time", font: .systemFont(ofSize: 16, weight: .semibold), textColor: #colorLiteral(red: 0.07251366228, green: 0.19975999, blue: 0.6398154497, alpha: 1))
    let barChartController = BarChartController(scrollDirection: .horizontal)

    lazy var barsContainerView: UIView = {
        let view = UIView()
        view.stack(views: self.titleLabel, self.barChartController.view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 8
        
        setupShadow(opacity: 0.05, radius: 8, offset: .init(width: 0, height: 12), color: .black)
        
        stack(views: titleLabel, barsContainerView, spacing: 12).withMargins(.init(top: 16, left: 16, bottom: 12, right: 16))
        
        setupBars()
    }
    
    private func setupBars() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct BarData {
    let index: Int
    let percentage: CGFloat
    let color: UIColor
}

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


class BarChartController: GenericController<BarChartCell, BarData, UICollectionReusableView>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (0..<32).forEach { (i) in
            let randomInt = Int.random(in: 0...2)
            var color = UIColor.red
            if randomInt == 1 {
                color = .green
            } else if randomInt == 2 {
                color = .blue
            }
            let random = CGFloat.random(in: 0..<1)
            items.append(BarData.init(index: i, percentage: random, color: color))
        }
        
        collectionView.reloadData()
        collectionView.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 14, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}

