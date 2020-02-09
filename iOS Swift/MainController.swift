//
//  MainController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 09/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.
//


import UIKit
import LBTATools

class PostCell: LBTAListCell<String> {
    
    let imageView = UIImageView(backgroundColor: .red)
    let nameLabel = UILabel(text: "Name Label")
    let dateLabel = UILabel(text: "Friday at 11:11AM")
    let postTextLabel = UILabel(text: "Here is my post")
//    let imageViewGrid = PhotosGridController
    
    let photosGridController = PhotosGridController()
    
    override func setupViews() {
        backgroundColor = .white
        
        stack(hstack(imageView.withHeight(40).withWidth(40),
                     stack(nameLabel, dateLabel),
            spacing: 8).padLeft(12).padRight(12).padTop(12),
              postTextLabel,
              photosGridController.view,
              spacing: 8)
    }
}

class StoryHeader: UICollectionReusableView {
    
    let storiesController = StoriestController(scrollDirection: .horizontal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
        stack(storiesController.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class StoryPhotoCell: LBTAListCell<String> {
    
    override var item: String! {
        didSet {
            imageView.image = UIImage(named: item)
        }
    }
    
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    
    let nameLabel = UILabel(text: "Lee Ji Fun", font: .systemFont(ofSize: 18), textColor: .white)
    
    override func setupViews() {
        imageView.layer.cornerRadius = 10
        
        stack(imageView)
        
        setupGradientLayer()
        
        stack(UIView(), nameLabel).withMargins(.allSides(8))
    }
    
    let gradientLayer = CAGradientLayer()
    
    private func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7 , 1.1]
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
}

class StoriestController: LBTAListController<StoryPhotoCell, String>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.items = ["pingy2", "pingy2", "pingy2", "pingy2"]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: view.frame.height - 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
}

class MainController: LBTAListHeaderController<PostCell, String, StoryHeader>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.items = ["Hello", "World"]
        
        collectionView.backgroundColor = .init(white: 0.9, alpha: 1)
        
        setupNavBar()
    }
    
    let fbLogoImageview = UIImageView(image: UIImage(named: "fb_logo"), contentMode: .scaleAspectFit)
    
    private func setupNavBar() {
        let coverWhiteView = UIView(backgroundColor: .white)
        view.addSubview(coverWhiteView)
        coverWhiteView.anchor(top: view.topAnchor, leading: view.leadingAnchor,
                              bottom: nil, trailing: view.trailingAnchor)
        let safeAreaTop = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        coverWhiteView.constrainHeight(safeAreaTop)
        
        let width = view.frame.width - 120 - 16 - 60
        let titleView = UIView(backgroundColor: .clear)
        titleView.frame = .init(x: 0, y: 0, width: width, height: 50)
        
        let searchButton = UIButton(title: "search", titleColor: .black)
        
        titleView.hstack(fbLogoImageview.withWidth(120), UIView().withWidth(width), searchButton.withWidth(60))
        
        navigationItem.titleView = titleView
        navigationItem.title = "My nav bar"
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeAreaTop = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0
        let magicalSafeAreaTop: CGFloat = safeAreaTop + (navigationController?.navigationBar.frame.height ?? 0)
        
        let offset = scrollView.contentOffset.y + magicalSafeAreaTop
        let alpha: CGFloat = 1 - ((scrollView.contentOffset.y + magicalSafeAreaTop) / magicalSafeAreaTop)
        
        fbLogoImageview.alpha = alpha
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 0, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 0, right: 0)
    }
    
}







import SwiftUI

struct MainPreview: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) -> UIViewController {
            return UINavigationController(rootViewController: MainController())
        }
        
        func updateUIViewController(_ uiViewController: MainPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {
            
        }
    }
    
}
