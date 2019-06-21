//
//  StretchsHeaderLayout.swift
//  StrechyHeaderCollectionView
//
//  Created by ivica petrsoric on 20/01/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class StretchsHeaderLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attributes) in
            
            // indexPath
//            attributes.indexPath.item
            
            guard let collectionView = collectionView else { return }
            let contentOffSetY = collectionView.contentOffset.y
            print(contentOffSetY)
            
            if contentOffSetY > 0 {
                return
            }
            
            let width = collectionView.frame.width
            let height = attributes.frame.height - contentOffSetY
            
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                attributes.frame = CGRect(x: 0, y: contentOffSetY, width: width, height: height)
            }
        })
        
        return layoutAttributes
    }
    
    // follow the streching of header, moving down up
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
