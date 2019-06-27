//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit


let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    let images: [String] = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "Images") 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        collectionView!.register(UINib(nibName: "CircularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        let imageView = UIImageView(image: UIImage(named: "bg-dark.jpg"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        collectionView!.backgroundView = imageView
    }
    
}

extension CollectionViewController {
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CircularCollectionViewCell
        cell.imageName = images[indexPath.row]
        return cell
    }
    
    
    
}

