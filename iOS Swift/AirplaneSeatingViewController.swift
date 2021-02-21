//
//  AirplaneSeatingViewController.swift
//  AirplaneSeats
//
//  Created by ivica petrsoric on 19/01/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class AirplaneSeatingViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    let spacing: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7 + 12 + 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        if (indexPath.item == 2 || indexPath.item == 6) && indexPath.section <= 7{
            cell.backgroundColor = .white
        } else {
            
            if indexPath.section <= 7 {
                cell.backgroundColor = .red
            } else if indexPath.section < 12 {
                cell.backgroundColor = .blue
            } else {
                cell.backgroundColor = .green
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numbSeatcInColum: CGFloat = 9
        let deviceHeight = (collectionView.frame.height - (numbSeatcInColum - 1 ) * spacing) / 9
        return .init(width: 50, height: deviceHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: spacing, bottom: 0, right: 0)
    }
    
}
