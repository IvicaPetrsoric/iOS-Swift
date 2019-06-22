//
//  ViewController.swift
//  AppStoreDemo
//
//  Created by Ivica Petrsoric on 05/12/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"
    private let largeCellId = "largeCellId"
    private let headerId = "headerId"
    
    var appCategories: [AppCategory]?
    var featuredApps: FeaturedApps?
    
    var service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Featured Apps"
        
        service.fetchFeaturedApps { (data) in
            self.appCategories = data.categories
            self.featuredApps = data
            self.collectionView?.reloadData()
        }
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        
        // header
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count{
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
            cell.appCategory = appCategories?[indexPath.item]
            cell.featuredAppsController = self

            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.appCategory = appCategories?[indexPath.item]
        cell.featuredAppsController = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 2{
            return CGSize(width: view.frame.width, height: 160)
        }
        
        return CGSize(width: view.frame.width, height: 230)
    }
    
    
    func showAppDetailForApp(app: App){
        let appDetailController = AppDetailController(collectionViewLayout: UICollectionViewFlowLayout())
        appDetailController.app = app
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    // header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        
        header.appCategory = featuredApps?.bannerCategory
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
}








