//
//  BarChartController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 24/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

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

