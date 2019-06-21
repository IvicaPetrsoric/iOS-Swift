//
//  StrechyHeaderController.swift
//  StrechyHeaderCollectionView
//
//  Created by ivica petrsoric on 20/01/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class StrechyHeaderController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate let padding: CGFloat = 16
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewLayout()
        setupCollectionView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupCollectionViewLayout() {
        // layout customization
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
            layout.minimumLineSpacing = 8
        }
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffSetY = scrollView.contentOffset.y
        print(contentOffSetY)
        
        if contentOffSetY > 0 {
            headerCell?.animator.fractionComplete = 0
            return
        }
        
        headerCell?.animator.fractionComplete = abs(contentOffSetY) / 100
    }
    
    var headerCell: HeaderCell?
    
    // header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderCell
        return headerCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 340)
    }
    
    // cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 2 * padding, height: 50)
    }
}
