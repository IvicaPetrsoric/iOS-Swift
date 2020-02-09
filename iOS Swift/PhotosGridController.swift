//
//  ContentView.swift
//  StackingEssentials
//
//  Created by ivica petrsoric on 07/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.
//

import UIKit
import SwiftUI
import LBTATools

class PhotoGridCell: LBTAListCell<String> {
    
    let imageView = UIImageView(image: UIImage(named: "pingy"), contentMode: .scaleAspectFill)
    
    override var item: String! {
        didSet {
            imageView.image = UIImage(named: item)
        }
    }
    
    override func setupViews() {
        backgroundColor = .yellow
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
}

class PhotosGridController: LBTAListController<PhotoGridCell, String>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .lightGray
        
        self.items = ["pingy", "pingy2", "pingy3", "pingy3", "pingy"]
    }
    
    let cellSpacing: CGFloat = 4
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.items.count == 4 {
            // do for 4 items
        }
        
        if indexPath.item == 0 || indexPath.item == 1 {
            let width = (view.frame.width - 3 * cellSpacing) / 2
            return .init(width: width, height: width)
        } else {
            let width = (view.frame.width - 4.1 * cellSpacing) / 3
            return .init(width: width, height: width)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}



struct PhotosGridPreview: PreviewProvider {
    
    static var previews: some View {
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<PhotosGridPreview.ContainerView>) -> UIViewController {
            return PhotosGridController()
        }
        
        func updateUIViewController(_ uiViewController: PhotosGridPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PhotosGridPreview.ContainerView>) {
            
        }
    }
}
