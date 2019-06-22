//
//  SwipingControllerExtension.swift
//  autolayout_X
//
//  Created by Ivica Petrsoric on 31/10/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

extension SwipingController{
    
    // notifikacija prijelaza iz portrait u landscape
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            // treba scrolati na točan index inače se krivo pozicionira collection view
            
            if self.pageControl.currentPage == 0{
                self.collectionView?.contentOffset = .zero
            }else{
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }) { (_) in
            
        }
    }
}
